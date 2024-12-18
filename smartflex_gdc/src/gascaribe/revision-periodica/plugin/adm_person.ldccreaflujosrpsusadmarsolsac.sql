create or replace PROCEDURE adm_person.ldccreaflujosrpsusadmarsolsac IS
/******************************************************************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2018-09-27
  Descripcion : Procedimiento que verifica que la orden de suspension tenga el tipo de comentario PARAM_TIPOCOMENT_OTSUSPSOLSAC
               ,y de acuerdo a la causal con que se legalice, genere una reconexion o genere una orden de revision,reparacion
               o certificacion.

  Parametros Entrada

  Valor de salida
    sbmen  mensaje
    error  codigo del error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION
   05/12/2022   jhinestroza  Jira OSF-739: *Se adiciona el control para validar los estados del producto (C-Castigado o 5-suspension Total),
                                            si presenta uno de estos no se realiza la creacion del tramite de reconexion.

   12/05/2021   HORBATH      CASO 602: *Crear un nuevo cursor llamado CUVALIDACAUTIPTRA. En este cursor se validará si el
                                       tipo de trabajo y causal están configurados en el nuevo parámetro llamado LDC_PARAREPE
                                       *Crear un nuevo cursor llamado CUDATAORDEN. Para obtener información de la orden legalizada.
                                       *comentariar las sentencia con los parametros PARAM_CAUSLEG_SACOTSUSP,
                                       PARAM_CAULEG_FAL_SACOTSUSPACOM, PARAM_CAUSLEG_SACOTSUSPACOM
  19-04-2024   Adrianavg	 OSF-2569: Se migra del esquema OPEN al esquema ADM_PERSON                                       
*******************************************************************************************************************************/
 CURSOR cuComment(inuOrderId or_order.order_id%type) is
  SELECT COUNT(*)
    FROM or_order_comment
   WHERE order_id = inuOrderId
     AND or_order_comment.comment_type_id = dald_parameter.fnugetnumeric_value('PARAM_TIPOCOMENT_OTSUSPSOLSAC');
  nuorderid    or_order.order_id%TYPE;
  nucausalid   ge_causal.causal_id%TYPE;
  nucount      NUMBER(6);
  sbCausparam  LDC_PARAREPE.PARAVAST%TYPE;
  nuparano         NUMBER(4);
  nuparmes         NUMBER(2);
  nutsess          NUMBER;
  sbparuser        VARCHAR2(30);
  sbmensa          VARCHAR2(2000);
  nucontacaus      NUMBER(4);
  nucontacausrein  NUMBER(4);

  --CASO 602---
  cursor CUVALIDACAUTIPTRA(INUTASKTYPEID number, INUCAUSALID number, IsbCausparam varchar2) is
    SELECT count(1) cantidad
      FROM DUAL
     WHERE INUTASKTYPEID || ';' || INUCAUSALID IN
           (select column_value
              from table(ldc_boutilities.splitstrings(IsbCausparam,
                                                      '|')));

  cursor CUDATAORDEN(INUORDERID number) is
    select oo.task_type_id, ooa.product_id
      from open.or_order oo, OR_ORDER_ACTIVITY ooa
     where oo.order_id = INUORDERID
       and oo.order_id = ooa.order_id;

  -- Jira OSF-739
  --<<
  CURSOR cuEstadoProducto(inuProducto pr_product.product_id%TYPE) IS
  SELECT COUNT(1) VALIDACION
  FROM   OPEN.servsusc
  WHERE  sesunuse = inuProducto AND (SESUESCO = 5 OR sesuesfn = 'C');

  blEstaCastigado       boolean;
  blGeneraComentario    boolean:= FALSE;
  nuValidacion          number;
  isbOrderComme         varchar2(4000) := 'No se generaron tramites adicionales, porque el estado de corte del producto es igual a [5 - SUSPESIÓN TOTAL] y/o su estado financiero es igual a CASTIGADO';
  nuCommentType         number := 1277;
  nuErrorCode           number;
  sbErrorMesse          varchar2(4000);
  -->>

  NUEXISTE      number; --establecer el resultado del nuevo cursor.
  NUTASKTYPEID  number; --establecer el tipo de trabajo de la orden legalizada.
  NUPRODUCTID   number; --establecer el producto de la orden legalizada.
  SBVALTIPOSUSP varchar2(10); --establecer el tipo de suspensión del producto.
  sbAplica602   varchar2(1);
  ------------------------------------

BEGIN

  nuorderid     := or_bolegalizeorder.fnuGetCurrentOrder;
  nucausalid    := daor_order.fnugetcausal_id(nuorderid);

  if fblaplicaentregaxcaso('0000602') then
    sbAplica602 :='S';
  else
    sbAplica602 :='N';
  end if;


  ---Iniico CASO 602
  if sbAplica602 = 'S' then
      open CUDATAORDEN(nuorderid);
      fetch CUDATAORDEN
        into NUTASKTYPEID, NUPRODUCTID;
      close CUDATAORDEN;

       SBVALTIPOSUSP := LDC_FSBVALIDASUSPCEMOACOMPROD(NUPRODUCTID);

       sbCausparam := DALDC_PARAREPE.fsbGetPARAVAST('TITR_CAUSAL_OTSUSPENSION',NULL);

         IF sbCausparam IS NULL THEN
          ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'No existe datos para el parametro "TITR_CAUSAL_OTSUSPENSION", definalos por el comando LDCPARP');
          RAISE ex.controlled_error;
         END IF;

           --Inicio CASO 602
      open CUVALIDACAUTIPTRA(NUTASKTYPEID, nucausalid, sbCausparam);
      fetch CUVALIDACAUTIPTRA
        into NUEXISTE;
      close CUVALIDACAUTIPTRA;
  else
    sbCausparam   := dald_parameter.fsbgetvalue_chain('PARAM_CAUSLEG_SACOTSUSPACOM',NULL);
      IF sbCausparam IS NULL THEN
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'No existe datos para el parametro "ID_CAUSAL_SUSP_REVI_RP", definalos por el comando LDPAR separados por coma');
        RAISE ex.controlled_error;
      end if;
  End if;
  OPEN cucomment(nuorderid);
  FETCH cuComment INTO nucount;
    IF cuComment%NOTFOUND THEN
      nucount := 0;
   END IF;
  CLOSE cuComment;


    -- Jira OSF-739
    --<<
    -- Reset de Variables
    NUTASKTYPEID  := NULL;
    NUPRODUCTID   := NULL;

    IF CUDATAORDEN%ISOPEN THEN
    CLOSE CUDATAORDEN;
    END IF;

    OPEN  CUDATAORDEN(nuorderid);
    FETCH CUDATAORDEN INTO NUTASKTYPEID, NUPRODUCTID;
    close CUDATAORDEN;

    IF cuEstadoProducto%ISOPEN THEN
    CLOSE cuEstadoProducto;
    END IF;

    OPEN  cuEstadoProducto(NUPRODUCTID);
    FETCH cuEstadoProducto INTO nuValidacion;
    close cuEstadoProducto;

    IF (nuValidacion > 0) THEN
      blEstaCastigado := true;
    ELSE
      blEstaCastigado := false;
    END IF;

  --Comentariado
  if sbAplica602='N' then
    SELECT nvl(SUM(cantidad),0) INTO nucontacaus
      FROM
          (
           SELECT COUNT(1) cantidad
             FROM open.ge_causal gc
            WHERE gc.causal_id = nucausalid
              AND gc.class_causal_id = 1
              AND gc.causal_id IN(
                                  SELECT to_number(column_value)
                                    FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('PARAM_CAUSLEG_SACOTSUSP'),','))
                                 )
            UNION ALL
           SELECT COUNT(1) cantidad
             FROM open.ge_causal gc
            WHERE gc.causal_id = nucausalid
              AND gc.class_causal_id = 2
              AND gc.causal_id IN(
                                 SELECT to_number(column_value)
                                   FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('PARAM_CAULEG_FAL_SACOTSUSPACOM'),','))
                                 )
          );

        IF nucount >= 1 AND nucontacaus >= 1 THEN
            IF (blEstaCastigado) THEN
                -- Adiciona comentario en la orden
                blGeneraComentario := TRUE;
            ELSE
                -- El producto NO se encuentra [5 - SUSPESIÓN TOTAL] y/o [C - CASTIGADO]
                EXECUTE IMMEDIATE 'BEGIN LDCPROCCREATRAMFLUJSACXML; END;';
            END IF;
        ELSE
            SELECT COUNT(1) INTO nucontacausrein
            FROM open.ge_causal gc
            WHERE gc.causal_id = nucausalid
            AND gc.class_causal_id = 1
            AND gc.causal_id IN(
                                SELECT to_number(column_value)
                                FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('PARAM_CAUSLEG_SACOTSUSPACOM'),','))
                                ) ;
            IF nucount >= 1 AND nucontacausrein >= 1 THEN
                IF (blEstaCastigado) THEN
                    -- Adiciona comentario en la orden
                    blGeneraComentario := TRUE;
                ELSE
                    -- El producto NO se encuentra [5 - SUSPESIÓN TOTAL] y/o [C - CASTIGADO]
                    ldcprocreatramrecsincertxml(nuorderid);
                END IF;
            ELSE
                -- Se valida si la orden esta marcada con el comentario
                IF nucount >= 1 THEN
                    IF (blEstaCastigado) THEN
                        -- Adiciona comentario en la orden
                        blGeneraComentario := TRUE;
                    END IF;
                END IF;
            END IF;
        END IF;
  else

        IF NUCOUNT >= 1 AND NUEXISTE = 1 THEN
            IF SBVALTIPOSUSP = 'CM' OR SBVALTIPOSUSP IS NULL THEN
                IF (blEstaCastigado) THEN
                    -- Adiciona comentario en la orden
                    blGeneraComentario := TRUE;
                ELSE
                    -- El producto NO se encuentra [5 - SUSPESIÓN TOTAL] y/o [C - CASTIGADO]
                    EXECUTE IMMEDIATE 'BEGIN LDCPROCCREATRAMFLUJSACXML; END;';
                END IF;
            ELSE
                IF SBVALTIPOSUSP = 'AC' THEN
                    IF (blEstaCastigado) THEN
                        -- Adiciona comentario en la orden
                        blGeneraComentario := TRUE;
                    ELSE
                        -- El producto NO se encuentra [5 - SUSPESIÓN TOTAL] y/o [C - CASTIGADO]
                        LDCPROCREATRAMRECSINCERTXML(NUORDERID);
                    END IF;
                END IF;
            END IF;
        ELSE
            -- Se valida si la orden esta marcada con el comentario
            IF nucount >= 1 THEN
                IF (blEstaCastigado) THEN
                    -- Adiciona comentario en la orden
                    blGeneraComentario := TRUE;
                END IF;
            END IF;
        END IF;

  --Fin CASO 602
  end if;

  -- Jira OSF-739
  IF (blGeneraComentario) THEN
        -- Adiciona comentario en la orden
        OS_ADDORDERCOMMENT( inuOrderId       => nuorderid,
                            inuCommentTypeId => nuCommentType,
                            isbComment       => isbOrderComme,
                            onuErrorCode     => nuErrorCode,
                            osbErrorMessage  => sbErrorMesse);
        IF (nuErrorCode <> 0) THEN
            errors.seterror;
            RAISE ex.controlled_error;
        END IF;
  END IF;

  sbmensa := 'Proceso termin? Ok.';

EXCEPTION
  WHEN ex.controlled_error THEN
    RAISE;
  WHEN OTHERS THEN
    sbmensa := SQLERRM;
    errors.seterror;
    RAISE ex.controlled_error;
END LDCCREAFLUJOSRPSUSADMARSOLSAC;
/
PROMPT OTORGA PERMISOS ESQUEMA SOBRE PROCEDIMIENTO LDCCREAFLUJOSRPSUSADMARSOLSAC
BEGIN
    pkg_utilidades.prAplicarPermisos('LDCCREAFLUJOSRPSUSADMARSOLSAC', 'ADM_PERSON'); 
END;
/