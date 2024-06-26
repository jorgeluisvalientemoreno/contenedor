PL/SQL Developer Test script 3.0
220
-- Created on 22/03/2023 by JORGE VALIENTE 
declare

  csbEntrega76 CONSTANT VARCHAR2(10) := '0000076';

  --PROCEDURE ldc_plugreconexseg IS
  /**************************************************************************
    Autor       :  Horbath
    Proceso     : ldc_plugreconexseg
    Fecha       : 2021-01-05
    Ticket      : 76
    Descripcion : plugin que genera orden de reconexion por seguridad
  
    Parametros Entrada
  
    Valor de salida
  
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
  nuOrderId      NUMBER;
  nuTipoCausalId NUMBER;
  nucausal       NUMBER;

  nuProducto NUMBER;
  nuCliente  NUMBER;

  sbComment      VARCHAR2(4000);
  ERROR          NUMBER;
  nuPackage_id   NUMBER;
  nuMotiveId     NUMBER;
  sbmensa        VARCHAR2(4000);
  nuExisteSusp   NUMBER := 0;
  nuUnidadOpera  NUMBER;
  nuPersona      NUMBER;
  nuCausalLeg    NUMBER := open.dald_parameter.fnuGetNumeric_Value('LDC_CAUSLEGERECOSEG',
                                                                   NULL);
  sbNombreoAtrib VARCHAR2(100) := open.DALD_PARAMETER.FSBGETVALUE_CHAIN('PARAM_NOMDATO_LECTURA',
                                                                        NULL);
  nuCodigoAtrib  NUMBER := Dald_parameter.fnuGetNumeric_Value('PARAM_DATO_LECTURA',
                                                              NULL);
  nuLectura      NUMBER;

  --se obtiene producto y cliente de la orden
  CURSOR cugetProducto IS
    SELECT oa.product_id, oa.subscriber_id
      FROM or_order_activity oa
     WHERE oa.order_id = nuOrderId;

  CURSOR cuValidaSuspension IS
    SELECT 1
      FROM open.pr_product p, open.pr_prod_suspension s
     WHERE p.product_id = s.product_id
       AND s.active = 'Y'
       AND p.product_status_id = 2
       AND p.product_id = nuProducto
       AND s.suspension_type_id = inuSUSPENSION_TYPE_ID;

  function fblAplicaEntregaxCaso(isbNumeroCaso In Varchar2) return boolean is
  
    /**************************************************************************
      Autor       : Elkin Alvarez / Horbath
      Fecha       : 2019-02-15
      Ticket      : 200-2431
      Descripcion : retorna si la aplica o no la entrega por caso
    
      Parametros Entrada
      isbNumeroCaso numero de caso
    
      Valor de salida
        retorna 0 si espera pago o 1 sino espera
     sbErrorMessage mensaje de error.
    
      nuError  codigo del error
      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
  
    --se valida aplicacion de entrega
    CURSOR cuAplicaEntrega IS
      Select a.Aplica
        From Ldc_Versionentrega t,
             Ldc_Versionempresa e,
             Ldc_Versionaplica  a,
             Sistema            s
       Where t.Codigo = a.Codigo_Entrega
         And e.Codigo = a.Codigo_Empresa
         And e.Nit = s.Sistnitc
         And T.Codigo =
             (SELECT max(t1.codigo)
                FROM Ldc_Versionentrega t1
               WHERE T1.Codigo_Caso like '%' || isbNumeroCaso || '%');
  
    -- Variables
    sbAplica Ldc_Versionaplica.Aplica%Type;
  
  BEGIN
  
    -- Se abre el cursor para validar si aplica la entrega
    Open cuAplicaEntrega;
    Fetch cuAplicaEntrega
      Into sbAplica;
    Close cuAplicaEntrega;
  
    -- Si aplica la entrega se retorna True, sino aplica se retorna False
    If Nvl(sbAplica, 'N') = 'S' Then
      Return True;
    Else
      Return false;
    End If;
  exception
    when others then
      return false;
  END fblAplicaEntregaxCaso;

BEGIN

  dbms_output.put_line('Antes de FBLAPLICAENTREGAXCASO');

  IF FBLAPLICAENTREGAXCASO(csbEntrega76) THEN
    dbms_output.put_line('Ingreso a FBLAPLICAENTREGAXCASO');
    /*Obtiene el id de la orden en la instancia*/
    /*nuOrderId      := or_bolegalizeorder.fnuGetCurrentOrder();
    nuTipoCausalId := dage_causal.fnugetclass_causal_id(daor_order.fnugetcausal_id(nuOrderId,
                                                                                   NULL),
                                                        NULL);
    
    IF nuTipoCausalId = 1 THEN
      --se carga producto y cliente
      OPEN cugetProducto;
    
      FETCH cugetProducto
        INTO nuProducto, nuCliente;
    
      CLOSE cugetProducto;
    
      OPEN cuValidaSuspension;
    
      FETCH cuValidaSuspension
        INTO nuExisteSusp;
    
      CLOSE cuValidaSuspension;
    
      IF nuExisteSusp != 0 THEN
        sbComment := 'RECONEXION POR SEGURIDAD OT LEGALIZADA[' || nuOrderId || ']';
      
        BEGIN
          SELECT p.person_id
            INTO nuPersona
            FROM open.or_order_person p
           WHERE p.order_id = nuOrderId;
        EXCEPTION
          WHEN OTHERS THEN
            nuPersona := NULL;
        END;
      
        nuUnidadOpera := open.daor_order.fnugetoperating_unit_id(nuOrderId,
                                                                 NULL);
      
        nuLectura := ldc_boordenes.fsbDatoAdicTmpOrden(nuOrderId,
                                                       nuCodigoAtrib,
                                                       TRIM(sbNombreoAtrib));
      
        IF nuLectura IS NULL THEN
          sbmensa := 'Proceso termino con errores : ' ||
                     'No se ha digitado Lectura';
          ERRORS.SETERROR(2741, sbmensa);
          RAISE ex.CONTROLLED_ERROR;
        END IF;
      
        prGeneRecoSeguridad(nuProducto,
                            nuCliente,
                            inuSUSPENSION_TYPE_ID,
                            sbComment,
                            nuPackage_id,
                            nuMotiveId,
                            error,
                            sbmensa);
      
        IF error <> 0 THEN
          ERRORS.SETERROR(2741, sbmensa);
          RAISE ex.CONTROLLED_ERROR;
        ELSE
          INSERT INTO LDC_BLOQ_LEGA_SOLICITUD
            (PACKAGE_ID_ORIG, PACKAGE_ID_GENE)
          VALUES
            (NULL, nuPackage_id);
        
          INSERT INTO LDC_ORDEASIGPROC
            (ORAPORPA,
             ORAPSOGE,
             ORAOPELE,
             ORAOUNID,
             ORAOCALE,
             ORAOITEM,
             ORAOPROC)
          VALUES
            (nuOrderId,
             nuPackage_id,
             nuPersona,
             nuUnidadOpera,
             nuCausalLeg,
             NULL,
             'RECOSEGU');
        END IF;
      END IF;
    END IF;*/
  END IF;

  dbms_output.put_line('Despues de FBLAPLICAENTREGAXCASO');

EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    dbms_output.put_line('RAISE EX.CONTROLLED_ERROR');
  WHEN OTHERS THEN
    dbms_output.put_line('ERRORS.seterror');
    dbms_output.put_line('RAISE EX.CONTROLLED_ERROR');
    --END ldc_plugreconexseg;

end;
0
0
