create or replace package LDC_PKGESTIOSUSPADMYVOLU is
  PROCEDURE PREXCLPRODSUSP;
  /**************************************************************************
    Autor       : Olsoftware
    Fecha       : 2021-03-10
    Ticket      : 498
    Proceso     : PREXCLPRODSUSP
    Descripcion : job que se encarga de excluir producto suspendidos por administrativa o voluntario

    Parametros Entrada

    Valor de salida

   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR   DESCRIPCION
  ***************************************************************************/
  
  PROCEDURE  PREJECPROCCTS(inuproducto IN NUMBER, isbMotivo IN VARCHAR2);
  /**************************************************************************
    Autor       : Olsoftware
    Fecha       : 2021-03-10
    Ticket      : 498
    Proceso     : PREJECPROCCTS
    Descripcion : proceso que se encarga de validar si un producto esta excluido o no

    Parametros Entrada
      inuproducto  codigo del producto
      isbMotivo  motivo de exclusion
    Valor de salida

   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR   		DESCRIPCION
	 01-03-2023   cgonzalez		OSF-925: Modificar minutos de espera para programar el job mediante parametro LDC_MINJOB
  ***************************************************************************/

end LDC_PKGESTIOSUSPADMYVOLU;
/
create or replace package body LDC_PKGESTIOSUSPADMYVOLU is
   PROCEDURE PREXCLPRODSUSP IS
    /**************************************************************************
    Autor       : Olsoftware
    Fecha       : 2021-03-10
    Ticket      : 498
    Proceso     : PREXCLPRODSUSP
    Descripcion : job que se encarga de excluir producto suspendidos por administrativa o voluntario

    Parametros Entrada

    Valor de salida

   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR   DESCRIPCION
  ***************************************************************************/
   sbMotivoSuspVol VARCHAR2(400) := DALDC_PARAREPE.FSBGETPARAVAST('LDC_MOTISUSVOLU', NULL);
   sbMotivoSuspAdm VARCHAR2(400) := DALDC_PARAREPE.FSBGETPARAVAST('LDC_MOTISUSADMIN', NULL);
   onuerror  NUMBER;
   osberror  VARCHAR2(4000);
   nuparano  NUMBER;
   nuparmes  NUMBER;
   nutsess   NUMBER;
   sbparuser  VARCHAR2(400);
   IsbCOD_PKG_TYPE_ID_FILTRO_SUSP VARCHAR2(4000) := ',' || replace(DALD_PARAMETER.fsbGetValue_Chain('COD_PKG_TYPE_ID_FILTRO_SUSP'),' ' ,'')  || ',';
   sbVencido           VARCHAR2(1);
   
   inuDias_Anti_Notf   NUMBER := nvl(Dald_parameter.fnuGetNumeric_Value('NUM_DIAS_ANTICIPAR_NOTIFI_RP',NULL),0);
   InuDias_dif          NUMBER := Dald_parameter.fnuGetNumeric_Value('NUM_DIAS_NOTIFICAR_RP',NULL);
   inuDias             NUMBER := Dald_parameter.fnuGetNumeric_Value('DIAS_SUSP_X_DEFECTO',NULL);
   inuDias_dif_repa    NUMBER := Dald_parameter.fnuGetNumeric_Value('NUM_DIAS_NOTIFICAR_RP_REPA',NULL);
   InuDias_repa_OIA    NUMBER := Dald_parameter.fnuGetNumeric_Value('DIAS_SUSP_X_DEFECTO_OIA',NULL);
  
   CURSOR cuGetTiposusp IS
   SELECT *
   FROM (SELECT p.product_id, decode(sp.SUSPENSION_TYPE_ID, 5, sbMotivoSuspVol, sbMotivoSuspAdm) tiposusp
   FROM pr_product p, pr_prod_suspension sp
   WHERE p.PRODUCT_ID = sp.PRODUCT_ID
    AND SUSPENSION_TYPE_ID in (5,11)
    AND ACTIVE = 'Y'
        ) d
    WHERE NOT EXISTS (SELECT 1 FROM LDC_PRODEXCLRP E WHERE  E.PRODUCT_ID = d.PRODUCT_ID and MOTIVO = tiposusp);
    
    CURSOR cuValiProdvenc(inuProducto IN NUMBER) IS
    SELECT 'X'
    FROM
        (
            (
                (
                    (
                        SELECT /*+ index (a IDX_LDC_PLAZOS_CERT03) */
                                a.ID_PRODUCTO
                        FROM   ldc_plazos_cert a
                        WHERE  plazo_min_suspension <= SYSDATE + inuDias_Anti_Notf --nvl(open.Dald_parameter.fnuGetNumeric_Value('NUM_DIAS_ANTICIPAR_NOTIFI_RP',NULL),0)
                            AND    is_notif IN ('YV', 'YR')
                            AND  a.ID_PRODUCTO = inuProducto
                        UNION
                        SELECT /*+ index (a IDX_LDC_MARCA_PRODUCTO02) */ a.id_producto
                        FROM   ldc_marca_producto a, ldc_plazos_cert    B
                        WHERE  fecha_ultima_actu <= (CASE WHEN a.medio_recepcion = 'E' THEN
                                                        SYSDATE - (inuDias_repa_OIA)  --open.Dald_parameter.fnuGetNumeric_Value('DIAS_SUSP_X_DEFECTO_OIA', NULL)
                                                     ELSE
                                                        SYSDATE - (inuDias +         -- open.Dald_parameter.fnuGetNumeric_Value('DIAS_SUSP_X_DEFECTO',NULL)
                                                                   inuDias_dif_repa  -- open.Dald_parameter.fnuGetNumeric_Value('NUM_DIAS_NOTIFICAR_RP_REPA',NULL)
                                                                   )
    							                     END)
                        AND    register_por_defecto = 'Y'
                        AND    is_notif IN ('YV', 'YR')
                        AND    a.id_producto = b.id_producto
                        AND  a.ID_PRODUCTO = inuProducto
                    )
                    INTERSECT
                        SELECT mo.PRODUCT_ID
                        FROM   mo_packages m, mo_motive mo, or_order_activity oa, or_order o
                        WHERE  m.package_id = oa.package_id
                        AND    m.PACKAGE_ID = mo.package_id
                        AND    oa.order_id = o.order_id
                        AND   mo.PRODUCT_ID = inuProducto
                        AND    m.PACKAGE_TYPE_ID = 100246   -- Notificacion Suspension x Ausencia de Certificado
                        AND    o.task_type_id = 10450       -- Suspension desde cm revisiones periodicas
                        AND    o.order_status_id = 20       -- Planeada
                )
                UNION
                (
                    (
                        SELECT /*+ index (a IDX_LDC_PLAZOS_CERT03) */
                                a.id_producto
                        FROM   ldc_plazos_cert a
                        WHERE  plazo_min_suspension <= SYSDATE + inuDias_Anti_Notf       -- nvl(Dald_parameter.fnuGetNumeric_Value('NUM_DIAS_ANTICIPAR_NOTIFI_RP',NULL),0)
                        AND    is_notif IN ('YV', 'YR')
                        AND  a.id_producto = inuProducto
                        UNION
                        SELECT /*+ index (a IDX_LDC_MARCA_PRODUCTO02) */
                                a.id_producto
                        FROM   ldc_marca_producto a, ldc_plazos_cert    B
                        WHERE  fecha_ultima_actu <= (CASE WHEN a.medio_recepcion = 'E' THEN
                                                            SYSDATE - (inuDias_repa_OIA) -- Dald_parameter.fnuGetNumeric_Value('DIAS_SUSP_X_DEFECTO_OIA', NULL)
                                                        ELSE
                                                            SYSDATE - (inuDias           -- Dald_parameter.fnuGetNumeric_Value('DIAS_SUSP_X_DEFECTO',NULL)
                                                                            +
                                                                       inuDias_dif_repa) -- Dald_parameter.fnuGetNumeric_Value('NUM_DIAS_NOTIFICAR_RP_REPA',NULL)
                                                     END)
                        AND    REGISTER_POR_DEFECTO = 'Y'
                        AND    is_notif IN ('YV', 'YR')
                        AND    a.id_producto = b.id_producto
                        AND  a.id_producto = inuProducto
    				)
    				MINUS
                        SELECT PRODUCT_ID
                        FROM   mo_packages m, ps_motive_status c, mo_motive x
                        WHERE  InStr(isbCOD_PKG_TYPE_ID_FILTRO_SUSP, ','||m.package_type_id||',') > 0   -- 265,266,100270,100156,100246,100153,100014,100237,100013,100294,100295,100321,100293
                        AND    c.MOTIVE_STATUS_ID = m.MOTIVE_STATUS_ID
                        AND    c.MOTI_STATUS_TYPE_ID = 2                -- Estado paquete
                        AND    c.MOTIVE_STATUS_ID NOT IN (14, 32, 51)   -- 14-Atendido 32-Anulado 51-Cancelada
                        AND    x.PACKAGE_ID = m.PACKAGE_ID
                        AND  X.PRODUCT_ID = inuProducto
    			)
                UNION
                (
                    SELECT /*+ index (a IDX_LDC_PLAZOS_CERT01) */
                           a.ID_PRODUCTO
                    FROM   ldc_plazos_cert a
                    WHERE  plazo_min_suspension <= sysdate + inuDias_Anti_Notf -- nvl(open.Dald_parameter.fnuGetNumeric_Value('NUM_DIAS_ANTICIPAR_NOTIFI_RP',NULL),0)
                    AND    is_notif in ('YV', 'YR')
                     AND  a.ID_PRODUCTO = inuProducto
                    INTERSECT
                    SELECT product_id
                    FROM  or_order_activity oa, or_order o
                    WHERE oa.order_id = o.order_id
                    AND   o.task_type_id = 10445    -- Visita validacion de trabajos reparacion
                    AND   o.order_status_id = 11    -- Bloqueada
                     AND  Oa.product_id = inuProducto
                )
            )
            MINUS
                (
                    SELECT PRODUCT_ID
                    FROM   pr_prod_suspension
                    WHERE  suspension_type_id IN (101, 102, 103, 104)
                    AND   active = 'Y'
                    AND  product_id = inuProducto
                )                    
        );
        
        
  BEGIN
     -- se hace este select para obtener la informacion a enviar al procedimiento ldc_proinsertaestaprog
		SELECT to_number(to_char(SYSDATE,'YYYY')),to_number(to_char(SYSDATE,'MM')),userenv('SESSIONID'),USER
		INTO nuparano,nuparmes,nutsess,sbparuser
		FROM dual;
      
    ldc_proinsertaestaprog(nuparano,nuparmes,'PREXCLPRODSUSP','En ejecucion',nutsess,sbparuser);
     IF FBLAPLICAENTREGAXCASO('000498') THEN
          IF InuDias IS NULL THEN
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,'No existe datos para el parametro DIAS_SUSP_X_DEFECTO, definalos por el comando LDPAR');
            RAISE ex.controlled_error;
          END IF;
          
          IF InuDias_dif IS NULL THEN
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,'No existe datos para el parametro NUM_DIAS_NOTIFICAR_RP, definalos por el comando LDPAR');
            RAISE ex.controlled_error;
          END IF;
          
          IF InuDias_dif_repa IS NULL THEN
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,'No existe datos para el parametro NUM_DIAS_NOTIFICAR_RP_REPA, definalos por el comando LDPAR');
            RAISE ex.controlled_error;
          END IF;
          
          IF InuDias_repa_OIA IS NULL THEN
              ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,'No existe datos para el parametro "  DIAS_SUSP_X_DEFECTO_OIA, definalos por el comando LDPAR');
              RAISE ex.controlled_error;
          END IF;

          FOR reg IN cuGetTiposusp LOOP
               onuError := 0;
               osbError := NULL;
              IF cuValiProdvenc%ISOPEN THEN
                CLOSE cuValiProdvenc;
              END IF;
              
              OPEN cuValiProdvenc(REG.PRODUCT_ID);
              FETCH cuValiProdvenc INTO sbVencido;
              IF cuValiProdvenc%FOUND THEN
                 LDC_PKGESTPREXCLURP.insprodexclrp ( REG.PRODUCT_ID,
                                                     REG.tiposusp,
                                                     NULL,
                                                     onuError ,
                                                     osbError);
                  IF onuError <> 0 THEN
                     LDC_PKGESTIONCASURP.proRegistraLogLegOrdRecoSusp( 'PREXCLPRODSUSP',
                                                                              SYSDATE,
                                                                               REG.PRODUCT_ID,
                                                                               NULL,
                                                                                osbError,
                                                                                 USER
                                                                                );
                     ROLLBACK;
                  ELSE
                    COMMIT;
                  END IF;
              END IF;
              CLOSE cuValiProdvenc;
           END LOOP;
       END IF;   
    ldc_proactualizaestaprog(nutsess,osberror,'PREXCLPRODSUSP','Termino');
	EXCEPTION
  	WHEN ex.controlled_error THEN
        ERRORS.GETERROR(onuerror, osberror);    
         ldc_proactualizaestaprog(nutsess,osberror,'PREXCLPRODSUSP','Termino con error');
    WHEN OTHERS THEN
      ERRORS.SETERROR;
      ERRORS.GETERROR(onuerror, osberror);
       ldc_proactualizaestaprog(nutsess,osberror,'PREXCLPRODSUSP','Termino con error');
  END PREXCLPRODSUSP;
  
 PROCEDURE  PREJECPROCCTS(inuproducto IN NUMBER, isbMotivo IN VARCHAR2) IS
  /**************************************************************************
    Autor       : Olsoftware
    Fecha       : 2021-03-10
    Ticket      : 498
    Proceso     : PREJECPROCCTS
    Descripcion : proceso que se encarga de validar si un producto esta excluido o no

    Parametros Entrada
      inuproducto  codigo del producto
      isbMotivo  motivo de exclusion
    Valor de salida

   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR   		DESCRIPCION
	 01-03-2023   cgonzalez		OSF-925: Modificar minutos de espera para programar el job mediante parametro LDC_MINJOB
  ***************************************************************************/
    sbexiste VARCHAR2(1);
    nuError NUMBER;
    sbError VARCHAR2(4000);
    
    CURSOR cuValidaProdMar IS
    SELECT 'X'
    FROM LDC_PRODEXCLRP 
    WHERE PRODUCT_ID = inuproducto
      AND MOTIVO = isbMotivo;
      
    CURSOR cuGetactivdadSusp IS
    SELECT ACTIVITY_ID
    FROM pr_product p, or_order_activity oa
    WHERE p.product_id = inuproducto
     AND oa.ORDER_ACTIVITY_ID = p.SUSPEN_ORD_ACT_ID;
    
    nuUltActiSusp NUMBER;
    sbWhat VARCHAR2(4000);
    nujob NUMBER;
    nuestacorte   number;
	
	nuMinutos	NUMBER := nvl(daldc_pararepe.fnugetparevanu('LDC_MINJOB', NULL), 1);

 BEGIN
    IF FBLAPLICAENTREGAXCASO('0000498') THEN
       OPEN cuValidaProdMar;
       FETCH cuValidaProdMar INTO sbexiste;
       CLOSE cuValidaProdMar;
       
       IF sbexiste IS NOT NULL THEN
         LDC_PKGESTIONCASURP.PRINDEPRODSUADVO(inuproducto,nuerror,sbError );
         
         IF nuerror = 0 THEN
            
            OPEN cuGetactivdadSusp;
            FETCH cuGetactivdadSusp INTO nuUltActiSusp;
            CLOSE cuGetactivdadSusp;
            
            INSERT INTO LDC_PRODRERP(PRREPROD, PRREACTI, PRREFEGE, PRREPROC, PRREOBSE, PRREFUEN) 
               VALUES(inuproducto,nuUltActiSusp, SYSDATE, 'N', 'MARCADO POR PROCESO PREJECPROCCTS', 'SUSPADMIVOLU');
               
              --se programa hilo
            sbWhat :=   'BEGIN'                                                 || ' ' ||
                      'LDC_PKGESTIONCASURP.PRJOBRECOYSUSPXPROD('            || ' ' ||
                          inuproducto  || ' ' ||
                          ');'                              || ' ' ||
                  'EXCEPTION'                                             || ' ' ||
                      'WHEN LOGIN_DENIED OR EX.CONTROLLED_ERROR THEN'     || ' ' ||
                          'RAISE;'                                        || ' ' ||
                      'WHEN OTHERS THEN'                                  || ' ' ||
                          'ERRORS.SETERROR;'                              || ' ' ||
                          'RAISE EX.CONTROLLED_ERROR;'                    || ' ' ||
                  'END;';

          dbms_job.submit(nujob, sbWhat, sysdate + nuMinutos/24/60); -- se programa la ejecucion (los jobs se eliminan automatiamente apenas terminan)
         END IF;
       END IF;
    END IF;
  EXCEPTION
    WHEN ex.controlled_error THEN
        RAISE ex.controlled_error ;
    WHEN OTHERS THEN
      ERRORS.SETERROR;
     RAISE ex.controlled_error ;
  END PREJECPROCCTS;
end LDC_PKGESTIOSUSPADMYVOLU;
/
grant execute on LDC_PKGESTIOSUSPADMYVOLU  to SYSTEM_OBJ_PRIVS_ROLE 
