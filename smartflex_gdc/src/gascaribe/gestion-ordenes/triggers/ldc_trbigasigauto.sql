create or replace TRIGGER lDC_TRBIGASIGAUTO

  BEFORE INSERT ON OR_ORDER_ACTIVITY

  REFERENCING OLD AS OLD NEW AS NEW

  FOR EACH ROW --FOLLOWS TRG_BIUOR_ORDER_ACTIVITY


--when (( NEW.ORDER_ID IS NOT NULL ) OR (NEW.PACKAGE_ID IS NOT NULL))

Declare

  /*****************************************************************

    Propiedad intelectual de PETI (c).

    Unidad         : LDC_TRBIGASIGAUTO

    Descripcion    : Este trigger fue generado para asignacion automatica
                     ya que el proceso de asignacion automatica de SmartFelx
                     no permite asignar la unidad operativa como se plantea
                     la necesidad de las GASERAS
    Autor          : Jorge Valiente
    Fecha          : 02/11/2013

    Historia de Modificaciones

      Fecha             Autor             Modificacion
    =========         =========         ====================
    16-Enero-2014    Jorge Valiente     NC 2493. Se realizo la modificacion del trigger para que
                                        identifique si el producto es generico o no.
                                        Esto con el fin de cubrir la ceracion del producto generico
                                        de la herramienta de SMARTFLEX a la cual no le asigna una
                                        categoria al momento de la venta de solo interna.
                                        La solucion es crear 2 cursores.
                                        - El 1er cursor que identifique si el prodcuto es generico.
                                        - El 2do cursor que obtenga la categoria con base a la direccion de la orden

    10-Febrero-2014  Jorge Valiente     Por solicitud del Ing. Luis Felipe Mora se realizo la modificacion del llamado
                                        del TRIGGER de asignacion automatica para que este TRIGGER realice el llamado al
                                        TRIGGER de OPEN llamado TRG_BIUOR_ORDER_ACTIVITY para lo relacionado con ordenes de
                                        emergencia.

    12-Febrero-2014  Jorge Valiente     ARANDA 2767: Se modifico el cursor llamado CUGE_SECTOROPE_ZONA
                                        para que el codigo de la zona y el sector operativo se utilizaran mediante
                                        variables de entrada en la consulta del cursor.
                                        ya que por recomendaciones de OPEN defnieron no utilizar su servicios de DA
                                        de los paquetes de primer nivel de las entidades

    15-Marzo-2014    Jorge Valiente     ARANDA 2786:PROCESO QUE PERMITIRA ASIGNAR A LA ORDEN
                                        LA UNIDAD OPERATIVA DEFINIDA EN POR UOBYSOL.
                                        ESTE SERVICIO FUE CREADO POR LA ANULACION DE LA
                                        LOGICA DE ASIGNACION AUTOMATICA YA QUE LOS PROCESOS
                                        DE MANEJO DE ORDENES DE OPEN EN SMARTFLEX
                                        NO PERMITE TENER TRIGGERS QUE PERMITAN REALIZAR
                                        DE FORMA AUTOAMTICA EL PROCESO DE ASIGNACIO.

   03-Mayo-2016      Caren Berdejo      CA 200-308 Se agrega condicion para bloqueos de ordenes.

   06-Enero-2017     Nivis Carrasquila  CA 200-703.Si la entrega aplica se valida si la forma desde la
                                        cual se realiza el proceso, tiene o no restricciones para la
                                        operaci?n que se va a hacer (forma ORCREST o Parametro: LDC_EXEBLOQLEGA

   03-Marzo-2017     Nivis Carrasquila  CA 200-1108. Se valida estado con el cual se genera la nueva OT
                                        de Revocaci?n (R-Registrada-->0).

    29-Diciembre-2017  Jorge Valiente   CASO 200-1334: Cambiar la causal de la orden configuradas en la forma FCBOG
    09-Marzo-2018      Jorge Valiente   CASO 200-1334: Por parte de la N1 Eliana Berdejo. Se solciita a demas de cambiar
                                                       la causal se establesta la orden generada en estado 11 - Bloqueada
                                                       establecida en el parametro COD_EST_BLO_OT
    09-Julio-2018      Jorge Valiente    CASO 200-1962: Ultizar el campo LEGALICE_TRY_TIMES para
                                                        establecer el bloqueo o no de la orden generada.
                                                        Se colocara la logica establecida por la N1 Diana Saltarin
                                                        -El llamdo del cursor CUOR_RELATED_ORDER del CASO 200-1334
                                                        sera colocado en comentario para que no sea valido
    17-Octubre-2018    Diana Saltarin	Caso 200-2230 Se modifica para que cuando se bloquee la orden se guarde el estado anterior.

    15-Mayo-2019        Eduardo Ceron   Caso 200-2550 Se modifica para que valide si existe una configuracion en ldc_paramtram,
                                                      en caso de existir se valida si existe un registro para una solicitud, paquete
                                                      y actividad igual, en caso de no ser asi se actualiza el estado de la orden
                                                      a 11-Bloqueado.
  ******************************************************************/



  --CURSOR PARA VALIDAR SI LA ORDEN YA TIENE

  --UNIDAD OPERATIVA ASIGNADA.

  Cursor cuor_order Is

    Select oo.*

      From or_order oo

     Where oo.order_id = :new.order_id

       And oo.operating_unit_id Is Null;



  tempcuor_order cuor_order%Rowtype;



  --CURSOR PARA PERMITIR REGISTRAR EN LA ENTIDAD

  --LDC_ORDER LAS ORDENES CON ACTIVIDAD CONFIGURADAS EN UOBYSOL

  Cursor culdc_orderexist Is

    Select items_id

      From ldc_package_type_oper_unit t

     Where t.items_id Is Not Null

       And t.items_id = decode(:new.activity_id, Null, :old.activity_id, :new.activity_id)

     Group By items_id;



  tempculdc_orderexist culdc_orderexist%Rowtype;



  Cursor cu_ldc_paramtram(id_order       or_order_activity.order_id%Type,

                          order_activity or_order_activity.order_activity_id%Type) Is

    Select package_type_id, activity_id

      From or_order_activity o, mo_packages p

     Where o.package_id = p.package_id

       And o.order_id = id_order

       And o.order_activity_id = order_activity;

    --TICKET 200-1377 LJLB -- se consulta sucriptor y cliente
  CURSOR cuConSuscriptor IS
  SELECT s.susccodi, s.suscclie
  FROM SUSCRIPC s, servsusc se
  WHERE s.susccodi = se.sesususc
    AND se.sesunuse = NVL(:new.product_id, :old.product_id ) ;

  nuSusc SUSCRIPC.susccodi%TYPE; --TICKET 200-1377 LJLB -- se almacena codigo de suscriptor
  nuClie SUSCRIPC.suscclie%TYPE; --TICKET 200-1377 LJLB -- se almacena codigo del cliente

  tempcu_ldc_paramtram cu_ldc_paramtram%Rowtype;



  controlled_exception Exception;



  sbdatain Varchar2(4000);



  nuconfiguracion Number;



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



  /*Variables CA 200-703*/

  csbentrega200703 Constant Varchar2(100) := 'OSS_DIS_NCZ_200703_2';

  --Se obtiene el estado actual de la orden para enviarla a la funcion que valida las restricciones

  sbestadoorden Varchar2(2);

  nuestadoorden Number;

  --Flag para validar si la actividad esta registringida para evitar que se cree la orden

  sbexistrestr Varchar2(1);

  --Aplicacion que Ejecuta

  sbapp  Varchar2(100);

  sbapp2 Varchar2(100);

  --Flag Forma OSF

  nues_osf Number := 0;

  --Formas donde estan restringidas las actividades

  sbformasrestringidas Varchar2(4000) := open.dald_parameter.fsbgetvalue_chain('LDC_EXEBLOQLEGA', Null);

  -------


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



  ut_trace.trace('INICIO LDC_TRBIGASIGAUTO', 10);



  If fblaplicaentrega(csbentrega200703) Then

    --**Inicio CA 200-703**

    Begin

      -- Se busca el nuevo estado de la orden

      nuestadoorden := open.daor_order.fnugetorder_status_id(:new.order_id);



    Exception

      When Others Then

        -- Si no esta a?n en OR_ORDER, se busca el estado en OR_ORDER_ACTIVITY.

        -- por ejemplo para: Ordenes Autonomas, Revocacion de ?rdenes

        ut_trace.trace('error: ' || substr(Sqlerrm, 1, 200), 10);

        sbestadoorden := :new.status;

        ut_trace.trace('estado or_order_Activity: ' || sbestadoorden, 10);



        Select Case

               -- Generada, Registrada

                 When sbestadoorden in ( 'P','R' ) Then

                  0

               -- Asignada

                 When sbestadoorden = 'A' Then

                  5

                 Else

                  8

               End

          Into nuestadoorden

          From dual;



    End;



    --Flag para validar si la actividad esta registringida para evitar que se cree la orden

    sbexistrestr := open.ldc_fsbvalidaactiv_bloq(to_number(:new.activity_id), nuestadoorden);



    ut_trace.trace('nuestadoorden: ' || nuestadoorden, 10);

    ut_trace.trace('Actividad: ' || :new.activity_id ||

                   ' | Existe Restriccion para la Actividad de la Orden?: ' || sbexistrestr, 10);



    -- Se busca el m?dulo desde el cual se llama la forma

    Begin

      sbapp := ut_session.getmodule;

    Exception

      When Others Then

        sbapp := '';

    End;



    -- Se busca la forma desde la cual se genera el proceso

    Begin

      sbapp2 := sa_boexecutable.getexecutablename;

    Exception

      When Others Then

        sbapp2 := '';

    End;



    --Se valida si el proceso se esta llamando desde las formas OSF parametrizadas.

    If instr(sbformasrestringidas, sbapp) > 0 Then

      nues_osf := 1;

    End If;



    -- Si la forma presenta restricci?n para la operaci?n, no se contin?a el proceso.

    If sbexistrestr = 'S' And nues_osf = 1 Then



      --Si hay restricciones, se instancia el error.

      ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error, chr(10) ||

                                        'La actividad de esta orden tiene restricciones para procesarse en esta Pantalla OSF.  ( Ver ORCREST o Parametro: LDC_EXEBLOQLEGA)' ||

                                        chr(10) ||

                                        'ut_session.getmodule: ' ||

                                        sbapp || chr(10) ||

                                        'sa_boexecutable.getexecutablename: ' ||

                                        sbapp2);



      Raise ex.controlled_error;

    End If;

    --**Fin CA 200-703**

  End If;



  v1 := :new.order_activity_id;

  v2 := :new.order_id;

  v3 := :new.activity_id;

  v4 := :old.order_id;

  v5 := :new.package_id;

  v6 := :old.package_id;



  If fblaplicaentrega('OSS_CON_CBB_200308_5') Then

    Begin

      Select package_type_id Into id_tramite From mo_packages Where package_id = :new.package_id;

    Exception

      When no_data_found Then

        id_tramite := Null;

      When Others Then

        id_tramite := Null;

    End;

    If id_tramite Is Not Null Then

       ut_trace.trace('id_tramite: ' || id_tramite, 10);

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

         ut_trace.trace('id_paramtram: ' || id_paramtram, 10);
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
            --or_bofwlockorder.lockorder(v2, 1296, 'ORDEN BLOQUEDA POR CONFIGURACION DE LA FORMA FCBOG');
            ---LDC_prBloqueaOrden(v2); 200-2230

            if causal_id_paramtram > 0 then
			        --200-2230
              begin
              select order_status_id into nuEstadoAnte
              from open.or_order o
              where o.order_id=v2;
              exception
                when others then
                  nuEstadoAnte := null;
              end;
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

               UT_TRACE.TRACE('VALIDACION SI EXISTE CONFIGURACION EN ldc_paramtram',10);
               IF nuValActRequest > 0 THEN
                     nuValOrderActivity :=  LDC_FNUGETCANTACTXPROD(:NEW.PACKAGE_ID,:NEW.PRODUCT_ID, :NEW.ACTIVITY_ID );                    
                    UT_TRACE.TRACE('VALIDACION SI ES LA PRIMERA ORDEN'||nuValOrderActivity,10);
                    IF nuValOrderActivity = 0 THEN
                           ut_trace.trace('ingreso actualzar : ' || nuValOrderActivity, 10);
                        --200-2230
                          update open.or_order oo set oo.causal_id = causal_id_paramtram, oo.order_status_id = nuCOD_EST_BLO_OT,
            			        prev_order_status_id = nuEstadoAnte --200-2230
            			        where oo.order_id= v2;

                    END IF;

               END IF;
            end if;

        /*
        --CASO 200-1334
          end if;
        end if;
        --CASO 200-1334
        */

      Else



        ldc_boasigauto.prregsitroasigauto(:new.package_id, :new.order_id, 'INICIO LDC_TRBIGASIGAUTO');



        sbdatain := 'PETI ACTIVIDAD OLD [' || :old.activity_id || '] - ACTIVIDAD NEW [' ||

                    :new.activity_id || '] - PRODUCTO OLD [' || :old.product_id ||

                    '] - PRODUCTO NEW [' || :new.product_id || '] - DIRECCION OLD [' ||

                    :old.address_id || '] - DIRECCION NEW [' || :new.address_id || ']';



        ldc_boasigauto.prregsitroasigauto(:new.package_id, :new.order_id, 'INICIO LDC_TRBIGASIGAUTO ' ||

                                           sbdatain);



        --CURSOR PARA VALIDAR SI LA ACTIVIDAD

        --ESTA CONFIGURADA EN UOBYSOL

        Open culdc_orderexist;

        Fetch culdc_orderexist

          Into tempculdc_orderexist;

        If culdc_orderexist%Found Then

          ldc_boasigauto.prregsitroasigauto(:new.package_id, :new.order_id, 'PASO EL CURSOR CULDC_ORDEREXIST');

          --CURSOR PARA VALIDAR SI LA ORDEN NO TIENE

          --UNIDAD OPERATIVA ASIGNADA

          Open cuor_order;

          Fetch cuor_order

            Into tempcuor_order;

          If cuor_order%Found Then

            ldc_boasigauto.prregsitroasigauto(:new.package_id, :new.order_id, 'PASO EL CURSOR CUOR_ORDER');



            Insert Into ldc_order (order_id, package_id) Values (:new.order_id, :new.package_id);

            ldc_boasigauto.prregsitroasigauto(:new.package_id, :new.order_id, 'INSERTAR DATOS');



          Else

            ldc_boasigauto.prregsitroasigauto(:new.package_id, :new.order_id, 'LA ORDEN NO EXISTE');



          End If;

          Close cuor_order;

          --FIN CURSOR CUOR_ORDER

        Else

          ldc_boasigauto.prregsitroasigauto(:new.package_id, :new.order_id, 'LA CONFIGURACION EN UOBYSOL NO EXISTE');



        End If;

        Close culdc_orderexist;

        --FIN CURSOR CULDC_ORDEREXIST

      End If;



    Else

      ldc_boasigauto.prregsitroasigauto(:new.package_id, :new.order_id, 'INICIO LDC_TRBIGASIGAUTO');



      sbdatain := 'PETI ACTIVIDAD OLD [' || :old.activity_id || '] - ACTIVIDAD NEW [' ||

                  :new.activity_id || '] - PRODUCTO OLD [' || :old.product_id ||

                  '] - PRODUCTO NEW [' || :new.product_id || '] - DIRECCION OLD [' ||

                  :old.address_id || '] - DIRECCION NEW [' || :new.address_id || ']';



      ldc_boasigauto.prregsitroasigauto(:new.package_id, :new.order_id, 'INICIO LDC_TRBIGASIGAUTO ' ||

                                         sbdatain);



      --CURSOR PARA VALIDAR SI LA ACTIVIDAD

      --ESTA CONFIGURADA EN UOBYSOL

      Open culdc_orderexist;

      Fetch culdc_orderexist

        Into tempculdc_orderexist;

      If culdc_orderexist%Found Then

        ldc_boasigauto.prregsitroasigauto(:new.package_id, :new.order_id, 'PASO EL CURSOR CULDC_ORDEREXIST');

        --CURSOR PARA VALIDAR SI LA ORDEN NO TIENE

        --UNIDAD OPERATIVA ASIGNADA

        Open cuor_order;

        Fetch cuor_order

          Into tempcuor_order;

        If cuor_order%Found Then

          ldc_boasigauto.prregsitroasigauto(:new.package_id, :new.order_id, 'PASO EL CURSOR CUOR_ORDER');



          Insert Into ldc_order (order_id, package_id) Values (:new.order_id, :new.package_id);

          ldc_boasigauto.prregsitroasigauto(:new.package_id, :new.order_id, 'INSERTAR DATOS');



        Else

          ldc_boasigauto.prregsitroasigauto(:new.package_id, :new.order_id, 'LA ORDEN NO EXISTE');



        End If;

        Close cuor_order;

        --FIN CURSOR CUOR_ORDER

      Else

        ldc_boasigauto.prregsitroasigauto(:new.package_id, :new.order_id, 'LA CONFIGURACION EN UOBYSOL NO EXISTE');



      End If;

      Close culdc_orderexist;

      --FIN CURSOR CULDC_ORDEREXIST

    End If;

  Else



    ldc_boasigauto.prregsitroasigauto(:new.package_id, :new.order_id, 'INICIO LDC_TRBIGASIGAUTO');



    sbdatain := 'PETI ACTIVIDAD OLD [' || :old.activity_id || '] - ACTIVIDAD NEW [' ||

                :new.activity_id || '] - PRODUCTO OLD [' || :old.product_id || '] - PRODUCTO NEW [' ||

                :new.product_id || '] - DIRECCION OLD [' || :old.address_id ||

                '] - DIRECCION NEW [' || :new.address_id || ']';



    ldc_boasigauto.prregsitroasigauto(:new.package_id, :new.order_id, 'INICIO LDC_TRBIGASIGAUTO ' ||

                                       sbdatain);



    --CURSOR PARA VALIDAR SI LA ACTIVIDAD

    --ESTA CONFIGURADA EN UOBYSOL

    Open culdc_orderexist;

    Fetch culdc_orderexist

      Into tempculdc_orderexist;

    If culdc_orderexist%Found Then

      ldc_boasigauto.prregsitroasigauto(:new.package_id, :new.order_id, 'PASO EL CURSOR CULDC_ORDEREXIST');

      --CURSOR PARA VALIDAR SI LA ORDEN NO TIENE

      --UNIDAD OPERATIVA ASIGNADA

      Open cuor_order;

      Fetch cuor_order

        Into tempcuor_order;

      If cuor_order%Found Then

        ldc_boasigauto.prregsitroasigauto(:new.package_id, :new.order_id, 'PASO EL CURSOR CUOR_ORDER');



        Insert Into ldc_order (order_id, package_id) Values (:new.order_id, :new.package_id);

        ldc_boasigauto.prregsitroasigauto(:new.package_id, :new.order_id, 'INSERTAR DATOS');



      Else

        ldc_boasigauto.prregsitroasigauto(:new.package_id, :new.order_id, 'LA ORDEN NO EXISTE');



      End If;

      Close cuor_order;

      --FIN CURSOR CUOR_ORDER

    Else

      ldc_boasigauto.prregsitroasigauto(:new.package_id, :new.order_id, 'LA CONFIGURACION EN UOBYSOL NO EXISTE');



    End If;

    Close culdc_orderexist;

    --FIN CURSOR CULDC_ORDEREXIST



  End If;

  --TICKET 200-1377 LJLB -- se consulta si aplica la entrega en la gasera
  IF fblaplicaentrega('BSS_FACT_LJLB_2001377_1') THEN
    --TICKET 200-1377 LJLB -- se valida que el tipo de trabajo este configurado en el parametro LDC_TITR_LECTRELE
    IF instr(dald_parameter.fsbGetValue_Chain('LDC_TITR_LECTRELE'),:NEW.TASK_TYPE_ID ) > 0 THEN
      --TICKET 200-1377 LJLB -- se consulta si la sucripcion o cliente estan vacios
      IF :NEW.SUBSCRIPTION_ID IS NULL OR :NEW.SUBSCRIBER_ID IS NULL THEN
          --TICKET 200-1377 LJLB -- se consulta suscriptor y cliente
          OPEN cuConSuscriptor;
          FETCH cuConSuscriptor INTO nuSusc, nuClie;
          CLOSE cuConSuscriptor;
          --TICKET 200-1377 LJLB --  se asigna suscriptor y cliente
          :NEW.SUBSCRIPTION_ID := nuSusc;
          :NEW.SUBSCRIBER_ID := nuClie;

      END IF;
    END IF;
  END IF;

  ut_trace.trace('FIN LDC_TRBIGASIGAUTO', 10);


Exception

  When ex.controlled_error Then

    Raise;

  When Others Then

    sbdatain := 'INCONSISTENCIA TRIGGER LDC_TRBIGASIGAUTO [' || dbms_utility.format_error_stack ||

                '] - [' || dbms_utility.format_error_backtrace || ']';

    ldc_boasigauto.prregsitroasigauto(:new.package_id, :new.order_id, 'Error ' || sbdatain);



End ldc_trbigasigauto;
/