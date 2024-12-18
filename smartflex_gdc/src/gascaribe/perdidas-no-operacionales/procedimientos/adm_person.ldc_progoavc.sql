create or replace PROCEDURE adm_person.ldc_progoavc(isbTablaId      IN VARCHAR2,
                                         inuCurrent      IN NUMBER,
                                         inuTotal        IN NUMBER,
                                         onuErrorCode    OUT NUMBER,
                                         osbErrorMessage OUT VARCHAR2) IS

    /*******************************************************************************
   Metodo:       LDC_PROGOAVC
   Descripcion:  Se agrega logica para la generacion de ordenes para productos
                 diferentes a Gas (7014).

   Autor:        Sebastian Tapias
   Fecha:        26/10/2017

   Historia de Modificaciones
   FECHA            AUTOR       DESCRIPCION 
   06/09/2018       ljlb        ticket 200-2132 Se agrega parametro LDC_ACTIVEXCLU en la logica de servicio de gas
   17/06/2019       HJM         200-2358: Se modifica llamado a or_boorderactivities.createactivity para enviarle dirección de producto y no la dirección de cobro del contrato
   24/04/2024       Adrianavg   OSF-2597: Se migra del esquema OPEN al esquema ADM_PERSON
  *******************************************************************************/  
  CURSOR cudatosproducto(nucuproducto pr_product.product_id%TYPE) IS
    SELECT cp.product_id          producto,
           cd.geograp_location_id localidad,
           cd.address_id          direccion,
           cp.product_type_id     tipo_producto
      FROM pr_product cp, ab_address cd
     WHERE cp.product_id = nucuproducto
       AND cp.address_id = cd.address_id;
  nuactividad  or_order_activity.activity_id%TYPE;
  sbcomentot   or_order_activity.Comment_%TYPE;
  sbcorreo     ge_person.e_mail%TYPE;
  onuid        NUMBER(15);
  onuorderid   NUMBER(15);
  onuPackageId NUMBER(15);
  nuerror      NUMBER;
  sberrorr     VARCHAR2(2000);
  sender       VARCHAR2(2000) := dald_parameter.fsbgetvalue_chain('LDC_SMTP_SENDER');
  nuparano     NUMBER(4);
  nuparmes     NUMBER(2);
  nutsess      NUMBER;
  sbparuser    VARCHAR2(30);
  nuproducto   pr_product.product_id%TYPE;
  ------------------CA 200-1408---------------------
  CURSOR cuProductos(nucuproducto pr_product.product_id%TYPE) is
    SELECT *
      FROM open.pr_product --
     WHERE product_id = nucuproducto;

  inuProduct_id pr_product.product_id%type;
  nuProductType pr_product.product_type_id%type;

  nuOrder_id         number;
  nuOrderActivity_id number;
  nuSubscriber_id    number;
  nuSubscription     number;
  nuAddress          number(15);
  --------------------------------------------------
BEGIN

    SELECT to_number(to_char(SYSDATE, 'YYYY')),
       to_number(to_char(SYSDATE, 'MM')),
       userenv('SESSIONID'),
       USER
    INTO nuparano, nuparmes, nutsess, sbparuser
    FROM dual;
     ldc_proinsertaestaprog(nuparano,
                             nuparmes,
                             'GOAVC',
                             'En ejecucion',
                             nutsess,
                             sbparuser);

  -------------Caso 200-1408--------------
  inuProduct_id := to_number(isbTablaId);
  --Obtener tipo de Producto
  nuProductType := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla('pr_product',
                                                                   'product_id',
                                                                   'product_type_id',
                                                                   inuProduct_id));
  ----------------------------------------
  nuactividad   := ge_boInstanceControl.fsbGetFieldValue('OR_ORDER_ACTIVITY',
                                                         'ACTIVITY_ID');
  sbcomentot    := ge_boInstanceControl.fsbGetFieldValue('OR_ORDER_ACTIVITY',
                                                         'COMMENT_');
  sbcorreo      := ge_boInstanceControl.fsbGetFieldValue('GE_PERSON',
                                                         'E_MAIL');
  sbcorreo      := lower(sbcorreo);
  --------------------- Logica Original GOAVC ----------------------
  IF (nuProductType = 7014 and instr(dald_parameter.fsbgetvalue_chain('LDC_ACTIVEXCLU'), nuactividad) = 0) THEN --TICKET 200-2132 LJLB -- se agrega logica para excluir por actividades
    BEGIN
      /*SELECT to_number(to_char(SYSDATE, 'YYYY')),
             to_number(to_char(SYSDATE, 'MM')),
             userenv('SESSIONID'),
             USER
        INTO nuparano, nuparmes, nutsess, sbparuser
        FROM dual;
      ldc_proinsertaestaprog(nuparano,
                             nuparmes,
                             'GOAVC',
                             'En ejecucion',
                             nutsess,
                             sbparuser);*/--TICKET 200-2132 LJLB -- se quita para manejar una sola logica
      FOR i IN cudatosproducto(to_number(isbTablaId)) LOOP
        nuproducto := i.producto;
        os_register_ntl(i.producto,
                        i.localidad,
                        i.direccion,
                        i.tipo_producto,
                        TRIM(sbcomentot),
                        0,
                        NULL,
                        'P',
                        nuactividad,
                        onuId,
                        onuOrderId,
                        onuPackageId,
                        nuerror,
                        sberrorr);
      END LOOP;
    /*  COMMIT;
      sberrorr := 'Proceso terminó Ok....';
      ldc_proactualizaestaprog(nutsess, sberrorr, 'GOAVC', 'Termino Ok.');
      --ldc_email.mail(sender,sbcorreo, 'Resultado proceso GOAVC', sberrorr);
    EXCEPTION
      WHEN OTHERS THEN
        nuerror  := -1;
        sberrorr := to_char(nuerror) ||
                    ' Error al generar la ordén de variación de consumo ' ||
                    to_char(nuerror) || ' producto ' || nuproducto || ' ' ||
                    SQLERRM;
        ldc_proactualizaestaprog(nutsess,
                                 sberrorr,
                                 'GOAVC',
                                 'Termino con error.');
        --ldc_email.mail(sender,sbcorreo, 'Resultado proceso GOAVC', sberrorr);*/--TICKET 200-2132 LJLB -- se quita para manejar una sola logica
    END;
    ---------------------Logica Ca 200-1487---------------------
 -- ELSIF (nuProductType <> 7014) THEN -TICKET 200-2132 LJLB -- se quita para colocar un else debido a que si no es servicio gas es otro servicio
  ELSE
    BEGIN
     /* SELECT to_number(to_char(SYSDATE, 'YYYY')),
             to_number(to_char(SYSDATE, 'MM')),
             userenv('SESSIONID'),
             USER
        INTO nuparano, nuparmes, nutsess, sbparuser
        FROM dual;
      ldc_proinsertaestaprog(nuparano,
                             nuparmes,
                             'GOAVC',
                             'En ejecucion',
                             nutsess,
                             sbparuser);*/--TICKET 200-2132 LJLB -- se quita para manejar una sola logica
      for reg in cuProductos(to_number(isbTablaId)) loop
        inuProduct_id      := reg.product_id;
        nuOrder_id         := NULL;
        nuOrderActivity_id := NULL;
        nuSubscriber_id    := pr_boproduct.fnugetsubscbyservnum(inuProduct_id);
        nuSubscription     := pktblservsusc.fnugetsesususc(inuProduct_id);
        --200-2358: Se modifica llamado a or_boorderactivities.createactivity para enviarle dirección de producto y no la dirección de cobro del contrato
        or_boorderactivities.createactivity(nuActividad,
                                            NULL,
                                            NULL,
                                            NULL,
                                            NULL,
                                            reg.address_id,
                                            NULL,
                                            nuSubscriber_id,
                                            nuSubscription,
                                            reg.product_id,
                                            NULL,
                                            NULL,
                                            NULL,
                                            or_boconstants.cnuprocess_manual_charges,
                                            TRIM(sbcomentot), --
                                            FALSE,
                                            NULL,
                                            nuOrder_id,
                                            nuOrderActivity_id,
                                            NULL,
                                            ge_boconstants.csbyes,
                                            NULL,
                                            NULL,
                                            NULL,
                                            NULL,
                                            NULL,
                                            TRUE,
                                            0);

      end loop;
    /*  commit;
      sberrorr := 'Proceso terminó Ok....';
      ldc_proactualizaestaprog(nutsess, sberrorr, 'GOAVC', 'Termino Ok.');
    EXCEPTION
      when others then
        nuerror  := -1;
        sberrorr := to_char(nuerror) ||
                    ' Error al generar la ordén de variación de consumo ' ||
                    to_char(nuerror) || ' producto ' || nuproducto || ' ' ||
                    SQLERRM;
        ldc_proactualizaestaprog(nutsess,
                                 sberrorr,
                                 'GOAVC',
                                 'Termino con error.');*/--TICKET 200-2132 LJLB -- se quita para manejar una sola logica
    END;
  END IF;

   commit;
   sberrorr := 'Proceso terminó Ok....';
   ldc_proactualizaestaprog(nutsess, sberrorr, 'GOAVC', 'Termino Ok.');
 EXCEPTION
      when others then
        nuerror  := -1;
        sberrorr := to_char(nuerror) ||
                    ' Error al generar la ordén de variación de consumo ' ||
                    to_char(nuerror) || ' producto ' || nuproducto || ' ' ||
                    SQLERRM;
        ldc_proactualizaestaprog(nutsess,
                                 sberrorr,
                                 'GOAVC',
                                 'Termino con error.');

END ldc_progoavc;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre procedimiento LDC_PROGOAVC
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PROGOAVC', 'ADM_PERSON'); 
END;
/
PROMPT OTORGA PERMISOS a REXEREPORTES sobre funcion LDC_PROGOAVC
GRANT EXECUTE ON ADM_PERSON.LDC_PROGOAVC TO REXEREPORTES;
/
