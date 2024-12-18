create or replace TRIGGER ADM_PERSON.LDC_TRG_OA_TITRREV
/**************************************************************************
  Propiedad Intelectual de Gases del caribe S.A E.S.P
  
  Funcion     : LDC_TRG_OA_TITRREV
  Descripcion : trigger que bloque ordenes de RP para asignacion manual
  Autor       : Horbath
  Ticket      : 147
  Fecha       : 19-12-2019
  
  Historia de Modificaciones
  Fecha               Autor               Modificacion
  =========           =========           ====================
  28/04/2020          dsaltarin           glpi 176 se modfiica para que si la unidad operativa es igual a la unidad dummy configurada en la tabla ldc_coactcasu
  
  05/07/2020          Horbath             CASO: 213 se modfiica para asiganar a la  unidad operativa de la ultima  orden 10444 asociada al producto.
  
  04/11/2020          Horbath             CASO: 466 se modfiica para validar configuracion de la tabla
  
  07/01/2021          dsaltarin           CASO 642: corección cambio 466, solo debe asignar las 10450 que sean de job de notificacion y suspension
  
  17/02/2021          Olsoftware          CASO 588: Se modifica el trigger para agregar la validacion BEFORE INSERT y se modifica el proceso actual del
                                          trigger colocandolo dentro del condicional IF UPDATING y el nuevo cambio de este caso dentro de IF INSERT, el 
                                          cambio 588 ingresa en la tabla "LDC_BLOQ_LEGA_SOLICITUD" las ordenes que sea de tipo de trabajo (11201, 12202,11200)
                                          para que no sea posible su asignacion por medio de ORCAO.
  22/04/2021          olsoftware          ca 668 validar si la ordne padre de los tipos de trabajo 10444 o 10795 sean del tipo de trabajo configurado
                                          en el parametro LDC_TITRPADRORDRP 
  25/11/2021          DANVAL              CA 833_1: Se validará la entrega 833 al inicio del proceso, si el Tipo de la Solicitud (MO_PACKAGES.PACKAGE_TYPE_ID) asociada es 100237 o 100295, si la solicitud existe en LDC_ORDENTRAMITERP, la ORDEN PADRE cumple con el tipo de Trabajo en TIPOTRABAJO_OPERARP y que este legalizada con causal de Éxito o El tipo de Trabajo este en TIPOTRABAJO_FALLORP que la causal definida en CAUSAL_FALLORP, se tomará la Unidad Operativa en LDC_ORDENTRAMITERP, se bloqueará la orden para asignación automática y se registrará la orden y unidad operativa en LDC_ORDEASIGPROC. Si la entrega no aplica o no cumple se continuara con el proceso ya implementado en el TRIGGER
  
  02/11/2022          lvalencia           OSF-648: Se modifica para validar 
                                          ademas de que solicitud exista en la 
                                          tabla ldc_ordentramiterp no haya sido
                                          procesada, flag del campor procesado 'N'.
  **************************************************************************/
  BEFORE INSERT OR UPDATE ON OR_ORDER_ACTIVITY
  REFERENCING OLD AS OLD NEW AS NEW
  FOR EACH ROW
  WHEN (new.order_id is not null and (new.order_id <> NVL(old.order_id, 0)))

DECLARE
  --CA 833_1
  nuValidaTS        number := 0;
  nuOrdenPadre      number;
  sbTipoTrabOperaRP open.ldc_pararepe.paravast%type := DALDC_PARAREPE.FSBGETPARAVAST('TIPOTRABAJO_OPERARP',
                                                                                     NULL);
  nuTipoTrabOperaRP number;
  sbTipoTrabFalloRP open.ldc_pararepe.paravast%type := DALDC_PARAREPE.FSBGETPARAVAST('TIPOTRABAJO_FALLORP',
                                                                                     NULL);
  nuTipoTrabFalloRP number;
  sbCausalFalloRP   open.ldc_pararepe.paravast%type := DALDC_PARAREPE.FSBGETPARAVAST('CAUSAL_FALLORP',
                                                                                     NULL);
  nuCausalFalloRP   number;
  nuCausal          number;
  nuTipoCausal      number;
  nuTipoTrabajo     number;
  NUUNITOPER        number;
  nuFind            number;
  --
  sbTitrRP     VARCHAR2(4000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_TITRREVPERIOD',
                                                                  NULL); --se almacena tipos de trbajo de RP
  nuexiste     NUMBER; --se almacena si el tipo de trabajo es Rp
  nuEstadoSusp NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('ESTADO_PRODCUTO_SUSPENDIDO',
                                                            NULL); --se almacena estado del producto suspendido
  sbTipoSuspRp VARCHAR2(1000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('ID_RP_SUSPENSION_TYPE',
                                                                  NULL); --se almacena tipo de suspension RP
  sbDatos      VARCHAR2(1); --se almacena si el producto esta suspendido
  nuUnidadOpe  NUMBER; --se almacena unidad operativa
  --213
  nuTipo10795    number;
  nuUltup        number;
  sbIntExt       or_operating_unit.es_externa%type;
  sbValidaRol    open.ld_parameter.value_chain%type := nvl(DALD_PARAMETER.FSBGETVALUE_CHAIN('VALIDA_ACTIVIDAD_ROL_147',
                                                                                            NULL),
                                                           'N');
  nuExisteActRol number;
  sbTitrSuspRP   open.ldc_pararepe.paravast%type := daldc_pararepe.fsbgetparavast('COD_TT_SUS_RP',
                                                                                  null);
  nuAsigno147    varchar2(1) := 'N';
  nuValact       number := 0; --caso:466
  nuDep          number; --caso:466
  dtplazmin      date; --caso:466
  nuValconf      number := 0; --caso:466
  nuValOrdProv   number := 0; --caso:466
  nuExtistebloq  number := 0; --caso:466

  --588
  --CA 833_1
  --Se bloquea no se utiliza la variable
  --NUVALTT      NUMBER; -- CASO 588
  nuValSolBloq number := 0; -- CASO 588
  nuEsTitrDef  number := 0;
  nuEsTitrCer  number := 0;
  nuUnidadSV   open.or_operating_unit.operating_unit_id%type;
  --588

  nuAsignaAutomaticaPadre number;

  nuRowId   VARCHAR2(4000);

  cursor cuAsignacionAutomatica is
    with tabla as
     (select to_number(substr(column_value, 0, instr(column_value, '|') - 1)) titr,
             to_number(substr(column_value, instr(column_value, '|') + 1)) titrpadre
        from table(open.ldc_boutilities.splitstrings(DALD_PARAMETER.FSBGETVALUE_CHAIN('TITR_PADRE_NOASIGNA_213',
                                                                                      NULL),
                                                     ',')))
    
    select count(1)
      from open.ldc_asigna_unidad_rev_per per, tabla
     where per.solicitud_generada = :new.package_id
       and per.tipo_trabajo = tabla.titrpadre
       and tabla.titr = :new.task_type_id;
  --213

  --se obtiene direccion del producto
  CURSOR cugetValiEstaProd IS
    SELECT 'X'
      FROM pr_product p
     WHERE p.product_id = :NEW.product_id
       AND p.product_status_id = nuEstadoSusp
       AND EXISTS (SELECT 1
              FROM PR_PROD_SUSPENSION pr
             WHERE pr.PRODUCT_ID = p.product_id
               AND pr.SUSPENSION_TYPE_ID IN
                   (SELECT to_number(column_value) tisup
                      FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(sbTipoSuspRp,
                                                              ',')))
               AND pr.ACTIVE = 'Y');

  --CA 833_1
  --Se bloquea no se utliza
  --sbmensa varchar2(4000);
  nuTitr NUMBER;

  --INICIO CASO:466
  CURSOR cuValAct IS
    SELECT 1,
           open.dage_geogra_location.fnugetgeo_loca_father_id(open.daab_address.fnugetgeograp_location_id(:new.address_id)) departamento,
           PLAZO_MIN_REVISION
      FROM or_order oo, ldc_plazos_cert pl, pr_product pp
     where oo.order_id = :new.order_id
       and :new.ACTIVITY_ID in
           (SELECT to_number(column_value)
              FROM TABLE(open.ldc_boutilities.splitstrings(open.DALDC_PARAREPE.fsbGetPARAVAST('ACTIV_ASIGAUTO_XFECHMINREV'),
                                                           ',')))
       and :new.product_id = pp.product_id
       and pp.product_id = pl.ID_PRODUCTO
       and pp.category_id in
           (SELECT to_number(column_value)
              FROM TABLE(open.ldc_boutilities.splitstrings(open.DALDC_PARAREPE.fsbGetPARAVAST('CATEG_ASIGAUTO_XFECHMINREV'),
                                                           ',')));

  CURSOR cuExtistebloq IS
    Select 1
      from LDC_BLOQ_LEGA_SOLICITUD
     WHERE PACKAGE_ID_GENE = :NEW.PACKAGE_ID;

  CURSOR cuValconf(pAnio number, pMes number, pDep number) IS
    select 1
      from LDC_UNIT_RP_PLAMIN
     where ANIO = pAnio
       and MES = pMes
       AND DEPARTAMENTO = pDep;

  CURSOR cuValOrdProv IS
    select 1
      from ldc_asigna_unidad_rev_per la, or_order oo
     where oo.order_id = la.ORDEN_TRABAJO
       and la.solicitud_generada = :NEW.PACKAGE_ID
       and oo.task_type_id = 10450
       and oo.CAUSAL_ID in
           (SELECT to_number(column_value)
              FROM TABLE(open.ldc_boutilities.splitstrings(open.DALDC_PARAREPE.fsbGetPARAVAST('CAU_NO_ASIGAUTO_XFECHMINREV'),
                                                           ',')));
  --FIN CASO:466

  CURSOR cugetTiTr IS
    SELECT o.task_type_id FROM or_order o WHERE o.order_id = :new.order_id;

  --642
  sbCommentAsigna10450 open.ldc_pararepe.paravast%type := open.daldc_pararepe.fsbGetPARAVAST('COMENT_ASIGNA_SUSP_466',
                                                                                             null);

  nuSolicSuspen open.mo_packages.package_id%type;

  cursor cuComentSol is
    select p.package_id
      from open.mo_packages p
     where p.package_id = :new.package_id
       and p.package_type_id = 100156
       and sbCommentAsigna10450 like '%' || p.comment_ || '%';

  --176
  sbAplicaEntr176 varchar2(1);
  nuUnidadDummy   open.ldc_pararepe.parevanu%type;
  nuTask_typeSusp open.or_task_type.task_type_id%type;

  --INICIO CA 668
  nuOrden NUMBER;

  CURSOR CUVALIORIGORDDEN IS
    SELECT trim(substr(upper(p.comment_),
                       instr(upper(p.comment_), 'LEGALIZADA :') + 12,
                       instr(upper(p.comment_), 'CON CAUSAL') -
                       (instr(upper(p.comment_), 'LEGALIZADA :') + 12))) orden
      FROM open.mo_packages p
     WHERE p.package_id = :new.package_id;

  sbTitrPadre VARCHAR2(4000) := open.daldc_pararepe.fsbGetPARAVAST('LDC_TITRPADRORDRP',
                                                                   null);
  sbexiste    VARCHAR2(1);

  CURSOR cuExisteTitrPadr IS
    SELECT 'S'
      FROM or_order o
     WHERE o.order_id = nuOrden
       and o.task_type_id in
           (SELECT to_number(regexp_substr(sbTitrPadre, '[^,]+', 1, LEVEL)) AS TITR
              FROM dual
            CONNECT BY regexp_substr(sbTitrPadre, '[^,]+', 1, LEVEL) IS NOT NULL);
  --FIN CA 668
  function fnuGetTask_type_suspen return number is
    pragma autonomous_transaction;
    nuTitrSusp open.or_task_type.task_type_id%type;
  begin
    nuTitrSusp := open.daor_order_activity.fnugettask_type_id(open.dapr_product.fnugetsuspen_ord_act_id(:NEW.PRODUCT_ID,
                                                                                                        NULL),
                                                              null);
    return nuTitrSusp;
  exception
    when others then
      return null;
  end;
  --588
  function fnuGetUnidadServVar(sbParametro open.ld_parameter.value_chain%type)
    return number is
    pragma autonomous_transaction;
    nuUnidadServVar open.or_operating_unit.operating_unit_id%type;
  begin
    select o.operating_unit_id
      into nuUnidadServVar
      from open.or_order o, open.or_order_activity a, open.ge_causal c
     where o.order_id = a.order_id
       and o.task_type_id in
           (select To_Number(column_value)
              from table(open.ldc_boutilities.splitstrings(sbParametro, ',')))
       and o.order_status_id = 8
       and o.causal_id = c.causal_id
       and c.class_causal_id = 1
       and a.product_id = :New.product_id
       and o.order_id != :New.order_id;
    return nuUnidadServVar;
  exception
    when others then
      return - 1;
  end;

BEGIN
  UT_TRACE.TRACE('INICIA LDC_TRG_OA_TITRREV', 10);

  --CA 833_1
  /*Se validará que la entrega 833 este aplicada, se validará al inicio del proceso para garantizar la validación y asignación antes que cualquier otra*/
  IF FBLAPLICAENTREGAXCASO('0000833') THEN
    /*Se validará si el Tipo de la Solicitud (MO_PACKAGES.PACKAGE_TYPE_ID) asociada es 100237 o 100295*/
    select count(1)
      into nuValidaTS
      from MO_PACKAGES s
     where s.PACKAGE_TYPE_ID in (100237, 100295, 100294)
       and s.package_id = :new.package_id;
    if nuValidaTS > 0 then
      /*Se validará si la solicitud existe en LDC_ORDENTRAMITERP*/
      --------------------------------------------------------------
      -- OSF-648: Se modifica para validar si la solicitud existe --
      --          y no ha sido procesada (flag en 'N').           --
      --------------------------------------------------------------
      BEGIN
        SELECT  l.orden, l.unidadopera, l.causal, l.tipotrabajo, l.rowid as id
        INTO    nuOrdenPadre, nuUnitoper, nuCausal, nuTipoTrabajo, nuRowId
        FROM    ldc_ordentramiterp l
        WHERE   l.solicitud = :new.package_id
        AND     l.procesado = 'N' ;
      EXCEPTION
        WHEN no_data_found THEN
          nuOrdenPadre  := NULL;
          nuUnitoper    := NULL;
          nuCausal      := NULL;
          nuTipoTrabajo := NULL;
          nuRowId       := NULL;
      END;
      /*Si la ORDEN PADRE (la orden será obtenida a partir del registro asociado a la solicitud en la tabla LDC_ORDENTRAMITERP) cumple con alguna de las siguientes condiciones*/
      if nuOrdenPadre is not null then
        /*El tipo de Trabajo está definido en el parámetro TIPOTRABAJO_OPERARP y que este legalizada con causal de Éxito o El tipo de Trabajo este definido en el parámetro TIPOTRABAJO_FALLORP que este legalizada con alguna de las causales definidas en CAUSAL_FALLORP*/
        /*Se tomará la Unidad Operativa asociada en la tabla LDC_ORDENTRAMITERP si existe y se registrará en la variable NUUNITOPER*/
        if nuUnitoper is not null then
          nuTipoTrabajo := Daor_order.fnugettask_type_id(nuOrdenPadre, null);
          select count(1)
            into nuTipoTrabFalloRP
            from dual
           where nuTipoTrabajo in
                 (SELECT to_number(column_value)
                    FROM TABLE(open.ldc_boutilities.splitstrings(sbTipoTrabFalloRP,
                                                                 ',')));
          nuCausal := Daor_order.fnugetCausal_id(nuOrdenPadre, null);
          select count(1)
            into nuCausalFalloRP
            from dual
           where nuCausal in
                 (SELECT to_number(column_value)
                    FROM TABLE(open.ldc_boutilities.splitstrings(sbCausalFalloRP,
                                                                 ',')));
          select count(1)
            into nuTipoTrabOperaRP
            from dual
           where nuTipoTrabajo in
                 (SELECT to_number(column_value)
                    FROM TABLE(open.ldc_boutilities.splitstrings(sbTipoTrabOperaRP,
                                                                 ',')));
          nuTipoCausal := dage_causal.fnugetclass_causal_id(nuCausal, null);
          if (nuTipoTrabOperaRP > 0 and nuTipoCausal = 1) or
             (nuTipoTrabFalloRP > 0 and nuCausalFalloRP > 0) then
            /*Se bloqueará la orden para asignación automática para lo cual se registra en la tabla LDC_BLOQ_LEGA_SOLICITUD*/
            select count(*)
              into nuFind
              from LDC_BLOQ_LEGA_SOLICITUD
             where PACKAGE_ID_GENE = :NEW.PACKAGE_ID;
            if nuFind = 0 then
              INSERT INTO LDC_BLOQ_LEGA_SOLICITUD
                (PACKAGE_ID_GENE)
              VALUES
                (:NEW.PACKAGE_ID);
            end if;
            /*Se registrará la orden y unidad operativa en LDC_ORDEASIGPROC*/
            /*Se usará el proceso ASIGAUTRP*/
            INSERT INTO LDC_ORDEASIGPROC
              (ORAPORPA, ORAPSOGE, ORAOUNID, ORAOPROC)
            VALUES
              (:NEW.ORDER_ID, :NEW.PACKAGE_ID, NUUNITOPER, 'ASIGAUTRP');

            UPDATE  ldc_ordentramiterp 
            SET     procesado = 'S'
            WHERE   rowid = nuRowId;

            /*Al terminar el proceso finalizara el TRIGGER*/
            return;
          end if;
        end if;
      end if;
    end if;
  end if;
  /*Si la entrega no aplica o no cumple con las condiciones especificadas desde el punto 1.a. hasta 1.a.i.1.a. continuara con el proceso ya implementado en el TRIGGER*/
  --

  IF UPDATING THEN
    --- CAMBIO CASO 588
  
    ut_trace.trace('LDC_TRG_OA_TITRREV->UPDATING', 10);
    IF FBLAPLICAENTREGAXCASO('0000668') THEN
      BEGIN
        OPEN CUVALIORIGORDDEN;
        FETCH CUVALIORIGORDDEN
          INTO nuOrden;
        CLOSE CUVALIORIGORDDEN;
      
        IF nuOrden IS NOT NULL THEN
          OPEN cuExisteTitrPadr;
          FETCH cuExisteTitrPadr
            INTO sbExiste;
          if cuExisteTitrPadr%notfound then
            sbExiste := 'N';
          end if;
          CLOSE cuExisteTitrPadr;
        END IF;
      EXCEPTION
        WHEN OTHERS THEN
          sbExiste := 'N';
      END;
    Else
      sbExiste := 'N';
    END IF;
    IF FBLAPLICAENTREGAXCASO('0000176') THEN
      sbAplicaEntr176 := 'S';
    ELSE
      sbAplicaEntr176 := 'N';
      nuUnidadDummy   := null;
    END IF;
  
    IF FBLAPLICAENTREGAXCASO('0000147') THEN
      UT_TRACE.TRACE('SI APLICA ENTREGA CAMBIO 147');
      --Se vlida si el titr esta configurado como RP
      OPEN cugetTiTr;
      FETCH cugetTiTr
        INTO nuTitr;
      CLOSE cugetTiTr;
    
      SELECT COUNT(1)
        INTO nuexiste
        FROM (SELECT to_number(column_value) titr
                FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(sbTitrRP, ',')))
       WHERE titr = NVL(nuTitr, :NEW.TASK_TYPE_ID);
      UT_TRACE.TRACE('nuexiste: ' || nuexiste);
    
      if nuexiste > 0 then
        --se valida si el producto esta suspendido por RP   
        OPEN cugetValiEstaProd;
        FETCH cugetValiEstaProd
          INTO sbDatos;
        CLOSE cugetValiEstaProd;
        UT_TRACE.TRACE('sbDatos: ' || sbDatos);
      
        IF sbDatos IS NOT NULL THEN
          IF sbAplicaEntr176 = 'S' then
            nuTask_typeSusp := fnuGetTask_type_suspen();
            UT_TRACE.TRACE('nuTask_typeSusp: ' || nuTask_typeSusp, 10);
            if instr(sbTitrSuspRP, nuTask_typeSusp || ',') > 0 then
              --213
              begin
                SELECT distinct conf.cacsunid
                  into nuUnidadDummy
                  FROM open.ldc_coactcasu conf
                 where cacscasu =
                       decode(nuTask_typeSusp, 10450, 287, 12457, 397);
              exception
                when others then
                  nuUnidadDummy := null;
              end;
              IF nuUnidadDummy is null then
                ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                                 'No se encontro configuracion de unidad dummy en la forma LDCCACASU');
                raise ex.CONTROLLED_ERROR;
              end if;
            end if; --if instr(sbTitrSuspRP,nuTask_typeSusp||',')> 0 then 213
          END IF;
        
          --se obtiene unidad operativa de la ultima suspension
          LDC_PRCONUNOPSUP(:NEW.PRODUCT_ID, nuUnidadOpe);
          UT_TRACE.TRACE('nuUnidadOpe:' || nuUnidadOpe, 10);
        
          --213
          UT_TRACE.TRACE('sbValidaRol: ' || sbValidaRol, 10);
          if sbValidaRol = 'S' then
            nuExisteActRol := fnuValidaActividadRolUnidad(:New.activity_id,
                                                          nuUnidadOpe);
          else
            nuExisteActRol := 1;
          end if;
          --213
        
          IF nuUnidadOpe <> -1 and ((sbAplicaEntr176 = 'S' and
             nuUnidadOpe != nvl(nuUnidadDummy, 0)) or
             sbAplicaEntr176 = 'N') THEN
            IF nuExisteActRol > 0 then
              --213
              SELECT COUNT(1)
                INTO nuexiste
                FROM LDC_BLOQ_LEGA_SOLICITUD
               WHERE PACKAGE_ID_GENE = :NEW.PACKAGE_ID;
            
              IF nuexiste = 0 THEN
                nuAsigno147 := 'S';
                --se bloquea orden para asignacion
                INSERT INTO LDC_BLOQ_LEGA_SOLICITUD
                  (PACKAGE_ID_GENE)
                VALUES
                  (:NEW.PACKAGE_ID);
                UT_TRACE.TRACE('proceso 3' || :NEW.ORDER_ID, 10);
              
                --se inserta para asignacion auutomatica
                INSERT INTO LDC_ORDEASIGPROC
                  (ORAPORPA, ORAPSOGE, ORAOUNID, ORAOPROC)
                VALUES
                  (:NEW.ORDER_ID,
                   :NEW.PACKAGE_ID,
                   nuUnidadOpe,
                   'ASIGAUTRP');
              
              Else
                nuAsigno147 := 'N';
              END IF;
            end if; --IF nuExisteActRol > 0 then 213
          END IF;
        END IF;
      END IF;
      --213
    else
      nuAsigno147 := 'N';
      --213
    END IF;
  
    -------------------------- 
  
    IF open.dald_parameter.fsbGetValue_Chain('ASIGNACION_AUTOMATICA_CERT_213',
                                             null) = 'S' and
       nuAsigno147 = 'N' THEN
      ---
      --Se valida si esta en la tabla de asignación automatica
      --
    
      nuAsignaAutomaticaPadre := 0;
      open cuAsignacionAutomatica;
      fetch cuAsignacionAutomatica
        into nuAsignaAutomaticaPadre;
      close cuAsignacionAutomatica;
      if nuAsignaAutomaticaPadre = 0 then
        UT_TRACE.TRACE(':NEW.PRODUCT_ID : ' || :NEW.PRODUCT_ID, 10);
        nuTipo10795 := dald_parameter.fnugetnumeric_value('COD_TITR_10795',
                                                          NULL);
        nuUltup     := LDC_FNUULOTPRODUCTO(:new.PRODUCT_ID);
      
        OPEN cugetTiTr;
        FETCH cugetTiTr
          INTO nuTitr;
        CLOSE cugetTiTr;
      
        IF nuTitr = nuTipo10795 AND nuUltup <> -1 THEN
          --INICIO CA 668
          if sbExiste = 'S' then
            return;
          end if;
          --FIN CA 668
          sbIntExt := daor_operating_unit.fsbgetes_externa(nuUltup, null); -- SE VALIDAD SI LA UNIDAD OPERATIVA ES EXTERNA
        
          IF sbIntExt = 'Y' THEN
            --se bloquea orden para asignacion
            INSERT INTO LDC_BLOQ_LEGA_SOLICITUD
              (PACKAGE_ID_GENE)
            VALUES
              (:NEW.PACKAGE_ID);
          
            --se inserta para asignacion auutomatica
            INSERT INTO LDC_ORDEASIGPROC
              (ORAPORPA, ORAPSOGE, ORAOUNID, ORAOPROC)
            VALUES
              (:NEW.ORDER_ID, :NEW.PACKAGE_ID, nuUltup, 'ASIGAUTRP');
          
          END IF;
        
        END IF;
      End if; -- if nuAsignaAutomaticaPadre > 0 then 
    
    END IF;
    ------------------------------------------
    -----------------------------------------------------
    --inicio caso:466
    IF FBLAPLICAENTREGAXCASO('0000466') THEN
    
      OPEN cuValAct;
      FETCH cuValAct
        INTO nuValact, nuDep, dtplazmin;
      CLOSE cuValAct;
    
      OPEN cuValconf(TO_NUMBER(EXTRACT(YEAR FROM dtplazmin)),
                     TO_NUMBER(EXTRACT(MONTH FROM dtplazmin)),
                     nuDep);
      FETCH cuValconf
        INTO nuValconf;
      CLOSE cuValconf;
    
      OPEN cuValOrdProv;
      FETCH cuValOrdProv
        INTO nuValOrdProv;
      CLOSE cuValOrdProv;
    
      nuSolicSuspen := null;
      if :new.task_type_id = 10450 then
        open cuComentSol;
        fetch cuComentSol
          into nuSolicSuspen;
        if cuComentSol%notfound then
          nuSolicSuspen := null;
        end if;
        close cuComentSol;
      else
        nuSolicSuspen := 1;
        --INICIO CA 668
        if sbExiste = 'S' then
          return;
        end if;
        --FIN CA 668
      end if;
    
      IF nuValact = 1 AND nuValconf = 1 AND nuValOrdProv <> 1 and
         nuSolicSuspen is not null THEN
      
        --se inserta para asignacion auutomatica
        INSERT INTO LDC_ORDEASIGPROC
          (ORAPORPA, ORAPSOGE, ORAOPROC)
        VALUES
          (:NEW.ORDER_ID, :NEW.PACKAGE_ID, 'ASIGAUTPLAMIN');
      
        OPEN cuExtistebloq;
        FETCH cuExtistebloq
          INTO nuExtistebloq;
        CLOSE cuExtistebloq;
      
        IF nuExtistebloq <> 1 THEN
        
          --se bloquea orden para asignacion
          INSERT INTO LDC_BLOQ_LEGA_SOLICITUD
            (PACKAGE_ID_GENE)
          VALUES
            (:NEW.PACKAGE_ID);
        
        END IF; --nuExtistebloq=1
      
      END IF; --nuValact= 1 AND nuValconf= 1 AND nuValOrdProv= 1
    
    END IF; --FBLAPLICAENTREGAXCASO('0000466')
    --fin caso:466
    -----------------------------------------------------
  
  END IF;

  IF INSERTING THEN
    --- caso 588
    ut_trace.trace('LDC_TRG_OA_TITRREV->UPDATING', 10);
  
    ------------------------------  Inicio Caso 588 ----------------------------------------------
  
    IF fblAplicaEntregaxCaso('0000588') THEN
      ut_trace.trace('LDC_TRG_OA_TITRREV->Aplica 588', 10);
    
      if (cuExtistebloq%isopen) then
        close cuExtistebloq;
      end if;
    
      open cuExtistebloq;
      fetch cuExtistebloq
        into nuValSolBloq;
      close cuExtistebloq;
    
      BEGIN
        --Se validan si son defectos
        SELECT count(*)
          INTO nuEsTitrDef
          FROM open.or_order oo
         WHERE oo.order_id = :NEW.ORDER_ID
           AND (oo.task_type_id IN
               (select To_Number(column_value)
                   from table(open.ldc_boutilities.splitstrings(open.DALD_PARAMETER.fsbGetValue_Chain('TITR_ASIGN_DEFECTOS_REFORMAS',
                                                                                                      NULL),
                                                                ','))));
      
      EXCEPTION
        when others then
          nuEsTitrDef := 0;
        
      END;
    
      BEGIN
        --Se validan si son certificaciones
        SELECT count(*)
          INTO nuEsTitrCer
          FROM open.or_order oo
         WHERE oo.order_id = :NEW.ORDER_ID
           AND (oo.task_type_id IN
               (select To_Number(column_value)
                   from table(open.ldc_boutilities.splitstrings(open.DALD_PARAMETER.fsbGetValue_Chain('TITR_ASIGN_CERT_REFORMAS',
                                                                                                      NULL),
                                                                ','))));
      
      EXCEPTION
        when others then
          nuEsTitrCer := 0;
        
      END;
    
      IF (nuEsTitrDef > 0 Or nuEsTitrCer > 0) THEN
        IF nuEsTitrDef > 0 then
          nuUnidadSV := fnuGetUnidadServVar(open.dald_parameter.fsbGetValue_Chain('TITR_UNIDAD_ASIG_REFORMAS',
                                                                                  null));
        end if;
        IF nuEsTitrCer > 0 then
          nuUnidadSV := fnuGetUnidadServVar(open.dald_parameter.fsbGetValue_Chain('TITR_UNIDAD_ASIG_CERTVISIT',
                                                                                  null));
        end if;
      
        IF (nuValSolBloq != 1 and nvl(nuUnidadSV, -1) != -1) THEN
          -- se valida que la solicitud no este en la tabla LDC_BLOQ_LEGA_SOLICITUD
          --se bloquea orden para asignacion
          INSERT INTO LDC_BLOQ_LEGA_SOLICITUD
            (PACKAGE_ID_GENE)
          VALUES
            (:NEW.PACKAGE_ID);
        END IF;
      END IF;
    END IF;
    ------------------------------  Fin Caso 588 -------------------------------------------------+
  END IF;

  UT_TRACE.TRACE('FIN LDC_TRG_OA_TITRREV', 10);

EXCEPTION
  When ex.controlled_error Then
    Raise ex.controlled_error;
  WHEN OTHERS THEN
    --CA 833_1
    --Se bloquea no se utliza
    --sbmensa := sbmensa || SQLERRM;
    ERRORS.SETERROR;
    Raise ex.controlled_error;
END LDC_TRG_OA_TITRREV;
/
