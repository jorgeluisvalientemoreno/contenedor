CREATE OR REPLACE package adm_person.LDC_PKCONDICIONVISUALIZACION is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : 
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    07/07/2024              PAcosta         OSF-2889: Cambio de esquema ADM_PERSON                              
    ****************************************************************/    

  /*****************************************************************
  Propiedad intelectual Gases de Caribe

  Function  :  FNUEXISTESUSVOLRECPROREG
  Descripcion :  Valida si existe o no en estado registrado uan solicitud de
                 Suspensi?n Voluntaria Con Reconexi?n Programada en estado registrada

  Parametros  :  Entrada
                            Contrato
                 Salida
                            Numerico

  Retorno     : 1 ? Existe una solicitud 100012-Suspensi?n Voluntaria Con Reconexi?n Programada
                    en estado registrada.
                0 ? NO Existe una solicitud 100012-Suspensi?n Voluntaria Con Reconexi?n Programada
                    en estado registrada.

  Autor    :  Jorge Valiente
  Fecha    :  26/06/2018
  *****************************************************************/
  FUNCTION FNUEXISTESUSVOLRECPROREG(InuProducto IN NUMBER) RETURN NUMBER;

  /*****************************************************************
  Propiedad intelectual Gases de Caribe

  Function  :  FNUVALIDAESTFIN
  Descripcion :  Valida el estado financiero del contrato

  Parametros  :  Entrada
                            Contrato
                 Salida
                            Numerico

  Retorno     : 1   El estado financiero del suscriptor no est? al d?a.
                0   El estado financiero del suscriptor est? al d?a.

  Autor    :  Jorge Valiente
  Fecha    :  26/06/2018
  *****************************************************************/
  FUNCTION FNUVALIDAESTFIN(InuProducto IN NUMBER) RETURN NUMBER;

  /*****************************************************************
  Propiedad intelectual Gases de Caribe

  Function  :  FNUEXISTERP
  Descripcion :  Valida si existe o no una solicitud de RP en estado registrada y relacionada a
                 ciertas ordenes con tipo de trabajos en estado 0 y/o 5

  Parametros  :  Entrada
                            Contrato
                 Salida
                            Numerico

  Retorno     : 1   Existe una solicitud RP en estado registrada.
                0   NO Existe una solicitud RP en estado registrada.

  Autor    :  Jorge Valiente
  Fecha    :  27/06/2018
  *****************************************************************/
  FUNCTION FNUEXISTERP(InuProducto IN NUMBER) RETURN NUMBER;

  /*****************************************************************
  Propiedad intelectual Gases de Caribe

  Function  :  FNUEXISTEVENSERING
  Descripcion :  Valida si existe o no una solicitud de RP en estado registrada y relacionada a
                 ciertas ordenes con tipo de trabajos en estado 0 y/o 5

  Parametros  :  Entrada
                            Producto
                 Salida
                            Numerico

  Retorno     : 1 Existe solicitud RP pendiente en estado registra y tiene
                  ordernes de un tipo de trabajo en estado 0 o 5.
                0 NO Existe RP pendiente en estado registra o Existe solicitud RP pendiente en
                  estado registra y tiene NO ordernes de un tipo de trabajo en estado 0 o 5.


  Autor    :  Jorge Valiente
  Fecha    :  27/06/2018
  *****************************************************************/
  FUNCTION FNUEXISTEVENSERING(InuProducto IN NUMBER) RETURN NUMBER;

end LDC_PKCONDICIONVISUALIZACION;
/
CREATE OR REPLACE package body adm_person.LDC_PKCONDICIONVISUALIZACION is

  /*****************************************************************
  Propiedad intelectual Gases de Caribe

  Function  :  FNUEXISTESUSVOLRECPROREG
  Descripcion :  Valida si existe o no en estado registrado uan solicitud de
                 Suspension Voluntaria Con Reconexion Programada en estado registrada

  Parametros  :  Entrada
                            Producto
                 Salida
                            Numerico

  Retorno     : 1   Existe una solicitud 100012 - Suspension Voluntaria Con Reconexion Programada
                    en estado registrada.
                0   NO Existe una solicitud 100012 - Suspension Voluntaria Con Reconexion Programada
                    en estado registrada.

  Autor    :  Jorge Valiente
  Fecha    :  26/06/2018
  *****************************************************************/
  FUNCTION FNUEXISTESUSVOLRECPROREG(InuProducto IN NUMBER) RETURN NUMBER IS

    onuExiste number := 0;

    --CURSOR PARA VALIDAR EXISTENCIA DE SOLICITUD
    cursor cuSusVolRecPro is
      select COUNT(MP.PACKAGE_ID) CANTIDAD
        from MO_PACKAGES mp, MO_MOTIVE mm
       where mp.PACKAGE_ID = mm.package_id
         and mp.MOTIVE_STATUS_ID = NVL(OPEN.DALD_PARAMETER.fnuGetNumeric_Value('COD_EST_SOL_REG_100012',
                                                                               NULL),
                                       0)
         and mm.product_id = InuProducto
         and mp.PACKAGE_TYPE_ID = NVL(OPEN.DALD_PARAMETER.fnuGetNumeric_Value('COD_PACKAGE_TYPE_ID_100012',
                                                                              NULL),
                                      0);

    RFcuSusVolRecPro cuSusVolRecPro%ROWTYPE;

  BEGIN

    ut_trace.trace('INICIO LDC_PKCONDICIONVISUALIZACION.FNUEXISTESUSVOLRECPROREG',
                   1);

    if fblAplicaEntrega('BSS_CAR_JLV_2001635_1') then

      OPEN cuSusVolRecPro;
      FETCH cuSusVolRecPro
        INTO RFcuSusVolRecPro;
      IF cuSusVolRecPro%FOUND THEN
        IF RFcuSusVolRecPro.Cantidad > 0 THEN
          onuExiste := 1;
        END IF;
      END IF;
      CLOSE cuSusVolRecPro;

    else
      onuExiste := 0;
    end if;

    ut_trace.trace('FIN LDC_PKCONDICIONVISUALIZACION.FNUEXISTESUSVOLRECPROREG',
                   1);

    RETURN onuExiste;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 1;

  END FNUEXISTESUSVOLRECPROREG;

  /*****************************************************************
  Propiedad intelectual Gases de Caribe

  Function  :  FNUVALIDAESTFIN
  Descripcion :  Valida el estado financiero del contrato

  Parametros  :  Entrada
                            Producto
                 Salida
                            Numerico

  Retorno     : 1   El estado financiero del suscriptor no est? al d?a.
                0   El estado financiero del suscriptor est? al d?a.

  Autor    :  Jorge Valiente
  Fecha    :  26/06/2018
  *****************************************************************/
  FUNCTION FNUVALIDAESTFIN(InuProducto IN NUMBER) RETURN NUMBER IS

    onuExiste number := 1;

    --CURSOR PARA VALIDAR EXISTENCIA DE SOLICITUD
    cursor cuSERVSUSC is
      select COUNT(S.SESUNUSE) CANTIDAD
        from SERVSUSC S
       where S.SESUNUSE = InuProducto
         AND S.SESUESFN IN
             (select column_value
                from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('EST_FIN_CON',
                                                                                         NULL),
                                                        ',')))
         AND S.SESUSERV = NVL(OPEN.DALD_PARAMETER.fnuGetNumeric_Value('COD_TIP_SER_GAS',
                                                                      NULL),
                              0);

    RFcuSERVSUSC cuSERVSUSC%ROWTYPE;

  BEGIN

    ut_trace.trace('INICIO LDC_PKCONDICIONVISUALIZACION.FNUVALIDAESTFIN',
                   1);

    if fblAplicaEntrega('BSS_CAR_JLV_2001635_1') then

      OPEN cuSERVSUSC;
      FETCH cuSERVSUSC
        INTO RFcuSERVSUSC;
      IF cuSERVSUSC%FOUND THEN
        IF RFcuSERVSUSC.Cantidad > 0 THEN
          onuExiste := 0;
        END IF;
      END IF;
      CLOSE cuSERVSUSC;

    else
      onuExiste := 0;
    end if;

    ut_trace.trace('FIN LDC_PKCONDICIONVISUALIZACION.FNUVALIDAESTFIN', 1);

    RETURN onuExiste;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 1;

  END FNUVALIDAESTFIN;

  /*****************************************************************
  Propiedad intelectual Gases de Caribe

  Function  :  FNUEXISTERP
  Descripcion :  Valida si existe o no una solicitud de RP en estado registrada y relacionada a
                 ciertas ordenes con tipo de trabajos en estado 0 y/o 5

  Parametros  :  Entrada
                            Producto
                 Salida
                            Numerico

  Retorno     : 1   Existe una solicitud RP en estado registrada.
                0   NO Existe una solicitud RP en estado registrada.

  Autor    :  Jorge Valiente
  Fecha    :  27/06/2018
  *****************************************************************/
  FUNCTION FNUEXISTERP(InuProducto IN NUMBER) RETURN NUMBER IS

    onuExiste number := 0;

    --Cursor para obtener las solicitudes RP
    cursor cuRP is
      select MP.PACKAGE_ID Solicitud --Count(MP.PACKAGE_ID) CANTIDAD
        from MO_PACKAGES mp, MO_MOTIVE mm
       where mp.PACKAGE_ID = mm.package_id
         and mp.MOTIVE_STATUS_ID = NVL(OPEN.DALD_PARAMETER.fnuGetNumeric_Value('COD_EST_SOL_REG_RP',
                                                                               NULL),
                                       0)
         and mm.product_id = InuProducto
         and mp.PACKAGE_TYPE_ID = NVL(OPEN.DALD_PARAMETER.fnuGetNumeric_Value('COD_PACKAGE_TYPE_ID_RP',
                                                                              NULL),
                                      0);

    RFcuRP cuRP%ROWTYPE;

    --Cursor para obtener las solicitudes RP
    cursor cuOTVENSERING(InuPackage IN NUMBER) is
      select count(ooa.order_id) Cantidad
        from OR_ORDER_ACTIVITY ooa, or_order oo
       where ooa.package_id = InuPackage
         and ooa.order_id = oo.order_id
         and oo.TASK_TYPE_ID IN
             (select column_value
                from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('TT_ORD_SOL_REV_PER',
                                                                                         NULL),
                                                        ',')))
         and oo.ORDER_STATUS_ID IN
             (select column_value
                from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('EST_ORD_SOL_REV_PER',
                                                                                         NULL),
                                                        ',')));

    RFcuOTVENSERING cuOTVENSERING%ROWTYPE;

    --Fecha Final Certificacion
    cursor cuCertificado is
      select max(l.estimated_end_date) FECHA_FINAL_CERTIFICACION
        from pr_certificate l
       where l.product_id = InuProducto;

    RFcuCertificado cuCertificado%rowtype;

  BEGIN

    ut_trace.trace('INICIO LDC_PKCONDICIONVISUALIZACION.FNUEXISTERP', 1);

    if fblAplicaEntrega('BSS_CAR_JLV_2001635_1') then

      open cuRP;
      fetch cuRP
        into RFcuRP;
      if cuRP%found then

        open cuOTVENSERING(RFcuRP.Solicitud);
        fetch cuOTVENSERING
          into RFcuOTVENSERING;
        if cuOTVENSERING%found then
          if RFcuOTVENSERING.Cantidad = 0 then

            --Certificado Vigente
            open cuCertificado;
            fetch cuCertificado
              into RFcuCertificado;
            if cuCertificado%found then
              if nvl(RFcuCertificado.Fecha_Final_Certificacion, sysdate) <=
                 sysdate then
                onuExiste := 1;
              end if;
            end if;
            close cuCertificado;

          else
            onuExiste := 1;
          end if;
        end if;
        close cuOTVENSERING;

      else

        --Certificado Vigente
        open cuCertificado;
        fetch cuCertificado
          into RFcuCertificado;
        if cuCertificado%found then
          if nvl(RFcuCertificado.Fecha_Final_Certificacion, sysdate) <=
             sysdate then
            onuExiste := 1;
          end if;
        end if;
        close cuCertificado;

      end if;
      close cuRP;

    else
      onuExiste := 0;
    end if;

    ut_trace.trace('FIN LDC_PKCONDICIONVISUALIZACION.FNUEXISTERP', 1);

    RETURN onuExiste;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 1;

  END FNUEXISTERP;

  /*****************************************************************
  Propiedad intelectual Gases de Caribe

  Function  :  FNUEXISTEVENSERING
  Descripcion :  Valida si existe o no una solicitud de RP en estado registrada y relacionada a
                 ciertas ordenes con tipo de trabajos en estado 0 y/o 5

  Parametros  :  Entrada
                            Producto
                 Salida
                            Numerico

  Retorno     : 1 Existe solicitud RP pendiente en estado registra y tiene
                  ordernes de un tipo de trabajo en estado 0 o 5.
                0 NO Existe RP pendiente en estado registra o Existe solicitud RP pendiente en
                  estado registra y tiene NO ordernes de un tipo de trabajo en estado 0 o 5.


  Autor    :  Jorge Valiente
  Fecha    :  27/06/2018
  *****************************************************************/
  FUNCTION FNUEXISTEVENSERING(InuProducto IN NUMBER) RETURN NUMBER IS

    onuExiste number := 0;

    --Cursor para obtener las solicitudes Venta de Servicio de Ingenieria
    cursor cuVENSERING is
      select count(MP.PACKAGE_ID) Cantidad
        from MO_PACKAGES mp, MO_MOTIVE mm
       where mp.PACKAGE_ID = mm.package_id
         and mp.MOTIVE_STATUS_ID = NVL(OPEN.DALD_PARAMETER.fnuGetNumeric_Value('COD_EST_SOL_REG_100101',
                                                                               NULL),
                                       0)
         and mm.product_id = InuProducto
         and mp.PACKAGE_TYPE_ID = NVL(OPEN.DALD_PARAMETER.fnuGetNumeric_Value('COD_PACKAGE_TYPE_ID_100101',
                                                                              NULL),
                                      0);

    RFcuVENSERING cuVENSERING%ROWTYPE;

  BEGIN

    ut_trace.trace('INICIO LDC_PKCONDICIONVISUALIZACION.FNUEXISTEVENSERING',
                   1);

    if fblAplicaEntrega('BSS_CAR_JLV_2001635_1') then

      OPEN cuVENSERING;
      FETCH cuVENSERING
        INTO RFcuVENSERING;
      IF cuVENSERING%FOUND THEN
        IF RFcuVENSERING.Cantidad > 0 THEN
          onuExiste := 1;
        END IF;
      END IF;
      CLOSE cuVENSERING;

    else
      onuExiste := 0;
    end if;

    ut_trace.trace('FIN LDC_PKCONDICIONVISUALIZACION.FNUEXISTEVENSERING',
                   1);

    RETURN onuExiste;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 1;

  END FNUEXISTEVENSERING;

end LDC_PKCONDICIONVISUALIZACION;
/
PROMPT Otorgando permisos de ejecucion a LDC_PKCONDICIONVISUALIZACION
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PKCONDICIONVISUALIZACION', 'ADM_PERSON');
END;
/
PROMPT Otorgando permisos de ejecucion sobre LDC_PKCONDICIONVISUALIZACION para reportes
GRANT EXECUTE ON adm_person.LDC_PKCONDICIONVISUALIZACION TO rexereportes;
/