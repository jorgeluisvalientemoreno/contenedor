create or replace PROCEDURE adm_person.ldc_prvalegaordenpersec IS
 /**************************************************************************
    Autor       :  olsoftware
    Fecha       : 2020-12-02
    Ticket      : 532
    Proceso     : LDC_PRVALEGAORDENPERSEC
    Descripcion : Plugin que Valida la legalizaci?n de ?rdenes de persecuci?n

    Parametros Entrada

    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
	28/05/2021   Horbath	Caso:738 Se modificara para validar si el estado de corte del producto de la orden actual,
							est? configurado en el par?metro ?ESTA_CORT_SUSPEN?, antes de actualizar el esado de crte de un producto.
  29/11/2021   GDC      CASO 2021101611: Por solicitud de Ismael Uribe se realiza colcoar en comentario la logica
                                         en cargada de genera la ejecucion de forma dinamica del JOB
                                         LDC_PKGESTIONCASURP.PRJOBRECOYSUSPRP. Para evitar bloqueos.
 09/02/2022  JJJM     CA-923            Se activa la logica del JOB : LDC_PKGESTIONCASURP.PRJOBRECOYSUSPRP
                                        y se actualiza el campo SESUFECO de la tabla servsusc con la fecha
                                        de ejecucion de la orden de trabajo siempre y cuando este campo sea NULL
  16/03/2022  JorVal   Jira 170          * Identificar el llamado del cursor CUGETINFOPROD, Para que despu?s de este,
                                           reubicar la l?gica encargada de validar y actualizar el campo SESUFECO
                                           de la entidad SERVSUSC con al fecha de ejecuci?n final de la orden legalizada. Esta l?gica cambia de ubicaci?n debido a que estar? mejor contextualizada en esta nueva ubicaci?n
                                         * l?gica relacionada (la l?gica existen desde donde se validaci?n el estado de
                                           la orden legalizada sea deferente de 8 (Cerrada), hasta la instrucci?n encargada
                                           de crear el JOB de RP) con el cambio de tipo de suspensi?n de cartera a
                                           revisi?n peri?dica se valide que la edad de RP del producto
                                           sea mayor a 54 meses, es decir, ya el producto se encuentra apto para gestionar
                                           su revisi?n. Esto con el fin de que no se realice cambio de tipo de suspensi?n
                                           a un usuario que se encuentre a?n certificado.

  03/06/2022  dsaltarin  OSF-311           Se modificar para corregir la actualiacion de PR_COMP_SUSPENSION, estaba cambiando las fechas a
                                           todos los registros del producto
                                           Se corrige la actualizacion de MO_SUSPENSION_COMP no estaba idetificando correctamente los
                                           componentes a los cuales se colocaria fecha final
                                           Se actualiza el estado de los componentes y se registra suspesion en PR_COMP_SUSPENSION

   25/08/2022  IBecerra  OSF-528           Se modifica para que el producto en estado de corte 5, pase a estado de corte 3 y llame a PBMAFA
   19-04-2024	 Adrianavg	OSF-2569: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
    nuErrorCode number; --se almacena codigo de error
    sbmensa VARCHAR2(4000); --se almacena mensaje de error
    nuClasCausal NUMBER; --se almacena clase de causal
    nuorden NUMBER; --se almacena numero de orden
    nuProducto NUMBER;
    nuSuspId    pr_prod_suspension.prod_suspension_id%type;
    nuMotivo   NUMBER;
    nuTiposusp NUMBER;
    dtFechaFinal DATE;
    RCORDER DAOR_ORDER.STYOR_ORDER; -- se almacena registro de la orden de trabajo
    RCSUSPCONE      SUSPCONE%ROWTYPE;
    nuEstaCorRec  NUMBER;

    nuAddressId  NUMBER;
    inuLocaId   NUMBER;
    inuDepa NUMBER;
    nuEstadoCor NUMBER;
    nuOrdeactivId NUMBER;
    sbWhat  VARCHAR2(4000);
    nuJob NUMBER;
    nuVal NUMBER:=1; -- caso: 738
    nuValEstacor number; -- caso: 738

    sbTipoSuspRp VARCHAR2(4000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_TIPO_SUSPENSION_RP', NULL);
    --OSF-311
    dtFechaReg     date;

    CURSOR cuvalidaTipoSus IS
    SELECT p.prod_suspension_id,
          oa.product_id,
          p.register_date,
          suspension_type_id,
          oa.order_activity_id
    FROM pr_prod_suspension p, or_order_Activity oa
    WHERE p.product_id = oa.product_id
     AND p.suspension_type_id in ( SELECT to_number(regexp_substr(sbTipoSuspRp,'[^,]+', 1, LEVEL)) AS tiposusp
                                    FROM dual
                                    CONNECT BY regexp_substr(sbTipoSuspRp, '[^,]+', 1, LEVEL) IS NOT NULL)
     AND p.active = 'Y'
     AND oa.order_id = nuorden;

     ---Cursor para obtener el estado de corte anterior asociado al producto
    cursor cuGetEstadoAnte is
    select HCECECAN
    from hicaesco
    where hcecnuse = nuProducto
      and hcecfech = ( select max (hcecfech)
                       from hicaesco
                       where  hcecnuse = nuProducto);

      --Se obtiene informacion del producto
    CURSOR cugetInfoProd IS
    select *
    from servsusc
    where servsusc.sesunuse = nuProducto;

	cursor cuValEstacor(nuValEstacort number) is
        select count(1)
		from table(ldc_boutilities.splitstrings(
					DALD_PARAMETER.fsbGetValue_Chain('ESTA_CORT_SUSPEN',NULL),','))
					where column_value = nuValEstacort;

	  nuCambio number;

    regProducto cugetInfoProd%rowtype;

    cursor cupr_component(NUPRODUCT_ID PR_PRODUCT.PRODUCT_ID%type) is
      SELECT PC.* FROM pr_component pc where pc.product_id = NUPRODUCT_ID AND pc.component_status_id in (5,8);





  BEGIN
   IF FBLAPLICAENTREGAXCASO('0000532') THEN
      --Obtener el identificador de la orden  que se encuentra en la instancia
      nuorden:=   or_bolegalizeorder.fnuGetCurrentOrder;
      ut_trace.trace('Numero de la Orden:'||nuorden, 10);
      nuClasCausal := DAGE_CAUSAL.FNUGETCLASS_CAUSAL_ID(DAOR_ORDER.FNUGETCAUSAL_ID(nuorden, null),null); --se obtiene clase de causal

      --si la causal es de exito se realiza validacion
      IF nuClasCausal = 1 THEN
         RCORDER := DAOR_ORDER.FRCGETRECORD(nuorden);
         --se valida tipo de suspension

         OPEN cuvalidaTipoSus;
         FETCH cuvalidaTipoSus INTO nuSuspId, nuProducto, /*nuMotivo*/ dtFechaReg, nuTiposusp, nuOrdeactivId; --osf311
         CLOSE cuvalidaTipoSus;



         IF nuProducto IS NOT NULL THEN
            --se actualiza estado de corte
              --Inicio caso: 738
              IF fblaplicaentregaxcaso('0000738') THEN

                OPEN cuValEstacor(nvl(pktblservsusc.fnugetsesuesco(nuProducto),0));
                FETCH cuValEstacor INTO nuValEstacor;
                CLOSE cuValEstacor;
                IF nuValEstacor=1 THEN
                  nuVal:=0;
                END IF;

              END IF;

              IF nuVal=0 THEN
                UPDATE servsusc SET sesuesco = 3
                WHERE sesunuse = nuProducto;
                ldc_bosuspensions.ProcessNoBill(nuProducto);
              END IF;

              IF nuVal=1 THEN
                UPDATE servsusc SET sesuesco = 3
                WHERE sesunuse = nuProducto;
              END IF;
              --Fin caso: 738

              --se actualiza tipo de suspension
              update PR_PROD_SUSPENSION
                set INACTIVE_DATE = sysdate, active ='N'
              WHERE prod_suspension_id = nuSuspId;

              --OSF-311
              UPDATE PR_COMP_SUSPENSION CS
                SET INACTIVE_DATE = SYSDATE, active = 'N'
              /*WHERE COMP_SUSPENSION_ID IN (
                              SELECT P.COMP_SUSPENSION_ID
                              FROM PR_COMP_SUSPENSION P, pr_component C
                              WHERE c.product_id = nuProducto
                                  AND c.component_id = p.component_id);*/
              WHERE cs.component_id  IN (SELECT C.COMPONENT_ID
                                          FROM OPEN.PR_COMPONENT C
                                         WHERE C.PRODUCT_ID=nuProducto)
                And cs.suspension_type_id=nuTiposusp
                And cs.active  = 'Y';

              --OSF-311

              UPDATE MO_SUSPENSION SET ending_date = SYSDATE
              --WHERE MOTIVE_ID = nuMotivo AND SUSPENSION_TYPE_ID =nuTiposusp;
              WHERE SUSPENSION_TYPE_ID =nuTiposusp
                and trunc(REGISTER_DATE)=trunc(dtFechaReg)
                and MOTIVE_ID IN (select m.motive_id
                                       from open.mo_motive m
                                  where m.product_id = nuProducto
                                     and m.motive_type_id=7);

              UPDATE MO_SUSPENSION_COMP  SET ending_date =  SYSDATE
              WHERE COMPONENT_ID IN (
                              --OSF-311
                              /*SELECT c.component_id
                              FROM  pr_component C
                              WHERE c.product_id = nuProducto*/
                              select s.component_id
                              from open.mo_component s
                              inner join open.mo_motive m on m.motive_id=s.motive_id and m.product_id=nuProducto and m.motive_type_id=7
                              inner join open.mo_suspension ms on ms.motive_id=m.motive_id and ms.suspension_type_id=nuTiposusp and trunc(ms.register_date)=trunc(dtFechaReg)
                              --OSF-311
                              )
                AND SUSPENSION_TYPE_ID = nuTiposusp
                AND TRUNC(REGISTER_DATE) =  TRUNC(dtFechaReg);

              INSERT INTO PR_PROD_SUSPENSION (PROD_SUSPENSION_ID, PRODUCT_ID, SUSPENSION_TYPE_ID, REGISTER_DATE, APLICATION_DATE, ACTIVE)
                 VALUES (SEQ_PR_PROD_SUSPENSION.NEXTVAL, nuProducto, 2, RCORDER.EXECUTION_FINAL_DATE, RCORDER.EXECUTION_FINAL_DATE, 'Y');

              --OSF-311


                FOR reg IN cupr_component(nuProducto) LOOP
                    update pr_component pc
                    set pc.component_status_id = 8
                  where pc.product_id = nuProducto
                    and pc.component_id=reg.component_id;

                    update compsesu pc
                    set pc.cmssescm = 8
                  where pc.cmsssesu = nuProducto
                    and pc.cmssidco=reg.component_id;

                    insert into pr_comp_suspension
                      (comp_suspension_id,
                       component_id,
                       suspension_type_id,
                       register_date,
                       aplication_date,
                       inactive_date,
                       active)
                    values
                      (SEQ_PR_COMP_SUSPENSION.NEXTVAL,
                       reg.Component_Id,
                       2,
                       SYSDATE,
                       RCORDER.EXECUTION_FINAL_DATE,
                       NULL,
                       'Y');
                END LOOP;


              nuAddressId := dapr_product.fnugetaddress_id(nuProducto,null);
              --Obtener localidad
              inuLocaId := daab_address.fnugetGEOGRAP_LOCATION_ID(nuAddressId,null);
              --Obtener Departamento
              inuDepa := dage_geogra_location.fnugetgeo_loca_father_id(inuLocaId,null);

              --se consulta informacion del producto
              open cugetInfoProd;
              fetch cugetInfoProd into regProducto;
              close cugetInfoProd;

              --Inicio Jira 170
              IF regProducto.Sesufeco IS NULL AND nuProducto IS NOT NULL THEN
                UPDATE servsusc sg
                   SET sg.sesufeco = rcorder.execution_final_date
                 WHERE sg.sesunuse = nuProducto;
              END IF;
              --Fin Jira 170

              open cuGetEstadoAnte;
              fetch cuGetEstadoAnte into nuEstadoCor;
              close cuGetEstadoAnte;

              --se registra suspecone
              RCSUSPCONE.SUCOIDSC := SQIDSUSPCONE.NEXTVAL();
              RCSUSPCONE.SUCODEPA := inuDepa;
              RCSUSPCONE.SUCOLOCA := inuLocaId;
              RCSUSPCONE.SUCONUOR := nuorden;
              RCSUSPCONE.SUCOSUSC := regProducto.SESUSUSC;
              RCSUSPCONE.SUCOSERV := regProducto.SESUSERV;
              RCSUSPCONE.SUCONUSE := regProducto.SESUNUSE;
              RCSUSPCONE.SUCOTIPO := 'D';
              RCSUSPCONE.SUCOFEOR := RCORDER.EXECUTION_FINAL_DATE;
              RCSUSPCONE.SUCOCACD := 1;
              RCSUSPCONE.SUCOOBSE := 'SUSPENSION POR PERSECUCION DE CARTERA';
              RCSUSPCONE.SUCOCOEC := nuEstadoCor;
              RCSUSPCONE.SUCOCICL := regProducto.SESUCICL;
              RCSUSPCONE.SUCOORIM := PKCONSTANTE.NO;
              RCSUSPCONE.SUCOPROG := 'CUSTOMER';
              RCSUSPCONE.SUCOTERM := PKGENERALSERVICES.FSBGETTERMINAL;
              RCSUSPCONE.SUCOUSUA := PKGENERALSERVICES.FSBGETUSERNAME;
              RCSUSPCONE.SUCOFEAT := SYSDATE;
              RCSUSPCONE.SUCOCUPO := null;
              RCSUSPCONE.SUCOORDTYPE:=1;
              RCSUSPCONE.SUCOACTIV_ID:=nuOrdeactivId;

              IF ( PKACCREIVADVANCEMGR.GNUACTIVITYCONS IS NOT NULL ) THEN
                  RCSUSPCONE.SUCOACGC := PKACCREIVADVANCEMGR.GNUACTIVITYCONS;
              END IF;

              PKTBLSUSPCONE.INSRECORD( RCSUSPCONE );


              --Jira 170
              ---Nueva logica de validacion para establer si el prodcuto ingrese a cambiar el TS a RP si
              --la fecha de certificacion vigente del prodcuto es mayor a 54 meses
              IF OPEN.ldc_getEdadRP(nuProducto) > 54 and fblaplicaentregaxcaso('OSF-170') THEN
              -----

                  IF RCORDER.ORDER_STATUS_ID <> 8 THEN
                     UPDATE OR_ORDER SET ORDER_STATUS_ID = 8 WHERE ORDER_ID = RCORDER.ORDER_ID;
                     nuCambio := 1;
                  END IF;
                  --se valida si el usuario cumple con los requisitos para el cambio
                  LDC_PKGESTIONCASURP.PRINDEPRODSUCA(nuProducto,
                                                     nuEstaCorRec,
                                                     1,
                                                     nuErrorCode);
                 IF nuErrorCode <> 0 THEN
                    ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,'Producto ['||nuProducto||'] no cumple con las condiciones para realizar cambio de suspension, validar log');

                 END IF;

                 if nuCambio = 1 then
                    UPDATE OR_ORDER SET ORDER_STATUS_ID = RCORDER.ORDER_STATUS_ID WHERE ORDER_ID = RCORDER.ORDER_ID;
                 end if;

                 INSERT INTO LDC_PRODRERP (PRREPROD,  PRREFEGE, PRREPROC)
                   VALUES (nuProducto, SYSDATE, 'N');

                  IF fblaplicaentregaxcaso('0000923') THEN -- CA-923 JJJM

                    --se programa hilo
                    sbWhat :=   'BEGIN'                                                 || ' ' ||
                              'LDC_PKGESTIONCASURP.PRJOBRECOYSUSPRP('            || ' ' ||
                                  to_char(1)                         || ', ' ||
                                  to_char(1)                     || ', ' ||
                                  to_char(nvl(nuProducto,-1))                     || ' ' ||
                                  ');'                              || ' ' ||
                          'EXCEPTION'                                             || ' ' ||
                              'WHEN LOGIN_DENIED OR EX.CONTROLLED_ERROR THEN'     || ' ' ||
                                  'RAISE;'                                        || ' ' ||
                              'WHEN OTHERS THEN'                                  || ' ' ||
                                  'ERRORS.SETERROR;'                              || ' ' ||
                                  'RAISE EX.CONTROLLED_ERROR;'                    || ' ' ||
                          'END;';


                    dbms_job.submit(nujob, sbWhat, sysdate + 5/24/60); -- se programa la ejecucion (los jobs se eliminan automatiamente apenas terminan)
                 END IF;
              END IF; -- ondicion Jira 170
        END IF;
     END IF;
  END IF;
EXCEPTION
  WHEN ex.controlled_error THEN
     errors.geterror(nuErrorCode, sbmensa);
     RAISE ex.controlled_error;
 WHEN OTHERS THEN
    errors.seterror;
    RAISE ex.controlled_error;
 END LDC_PRVALEGAORDENPERSEC;
/
PROMPT OTORGA PERMISOS ESQUEMA SOBRE PROCEDIMIENTO LDC_PRVALEGAORDENPERSEC
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PRVALEGAORDENPERSEC', 'ADM_PERSON'); 
END;
/