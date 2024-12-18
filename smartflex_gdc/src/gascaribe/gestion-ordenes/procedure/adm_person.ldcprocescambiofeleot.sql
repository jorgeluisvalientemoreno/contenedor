CREATE OR REPLACE PROCEDURE ADM_PERSON.LDCPROCESCAMBIOFELEOT IS
  PRAGMA AUTONOMOUS_TRANSACTION;

    /*****************************************************************
    PROPIEDAD INTELECTUAL DE GASES DEl CARIBE S.A E.S.P
    
    UNIDAD         : LDCPROCESCAMBIOFELEOT
    DESCRIPCION    : SERVICIO que permite la ACTUALIZACION DE LA FECHA DE LEGALIZACION
    AUTOR          : SAMUEL PACHECO OROZCO   
    FECHA          : 08/04/2016
    
    PARAMETROS              DESCRIPCION
    ============         ===================
    
    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
    29/04/2024       PACOSTA           OSF-2598: Se crea el objeto en el esquema adm_person
    ******************************************************************/

  SBREQUEST_ID        GE_BOINSTANCECONTROL.STYSBVALUE;
  SBCOMMENTS          GE_BOINSTANCECONTROL.STYSBVALUE;
  SBREGISTER_DATE     GE_BOINSTANCECONTROL.STYSBVALUE;
  nustatuot           or_order.order_status_id%type;
  dtlegalization_date or_order.legalization_date%type;
  nuexi               number;
  nutipotrab          number;
  sbProg              ldc_au_cflot.programa%type; -- Programa
  nuot                number;
  

BEGIN

  --identifica la ot dada por forma
  SBREQUEST_ID := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE('OR_ORDER',
                                                        'ORDER_ID');
  nuot         := TO_NUMBER(SBREQUEST_ID);
  --identifica fecha nueva de legalizacion dada por forma
  SBREGISTER_DATE := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE('OR_ORDER',
                                                           'LEGALIZATION_DATE');
  --IDENTIFICA COMENTARIO
  SBCOMMENTS := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE('OR_OPER_UNIT_COMMENT',
                                                      'COMMENTS');

  --identifica estado de la orden a modificar
  nustatuot := daor_order.fnugetorder_status_id(SBREQUEST_ID);

  --si el estado es diferente a cerrada notifica mensaje

  if nustatuot != 8 then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'La Orden No este legalizada por favor, Verifique.');
  end if;

  ---VALIDA QUE EL TIPO DE TRABAJO ESTA CONFIGURADO COMO QUE PERMITE ACTUALIZAR FECHA
  select count(*)
    into nutipotrab
    from LDC_COTT_CFLO
   where task_type_id = daor_order.fnugettask_type_id(nuot);

  if nutipotrab = 0 then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'La Orden posee un tipo de trabajo,' ||
                                     daor_order.fnugettask_type_id(nuot) ||
                                     ', que no esta configurado en LDCCTCFLO, verifique');
  end if;
  -- valida que no tenga acta asociada
  select count(*) into nuexi from ct_order_certifica where order_id = nuot;

  if nuexi != 0 then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'La Orden se encuentre asociada a acta.');
  end if;

  --valida que la nueva fecha no supera fecha y hora actual
  if TO_DATE(SBREGISTER_DATE, UT_DATE.FSBDATE_FORMAT) >
     TO_DATE(sysdate, UT_DATE.FSBDATE_FORMAT) then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'La nueva fecha de legalización.' ||
                                     TO_DATE(SBREGISTER_DATE,
                                             UT_DATE.FSBDATE_FORMAT) ||
                                     ', es mayor a la fecha y hora actual.' ||
                                     TO_DATE(sysdate,
                                             UT_DATE.FSBDATE_FORMAT));

  end if;

  -- Se obtiene el programa

  sbProg := pkErrors.fsbGetApplication;

  IF sbProg IS null OR sbProg = '' THEN
    sbProg := 'LDCCFLOT';
  END IF;
  --IDENTIFICA FECHA DE LEGALIZACION ANTES DE MODIFICACION
  dtlegalization_date := daor_order.fdtgetlegalization_date(nuot);
  --ACTUALIZA LA FECHA DE LEGALIZACION
  daor_order.updlegalization_date(nuot, SBREGISTER_DATE);

  --  registra tabla de auditoria

  insert into ldc_au_cflot
    (order_id,
     fech_lega_ante,
     fech_lega_nuev,
     observacion,
     fecha,
     usuario,
     terminal,
     programa)
  values
    (TO_NUMBER(SBREQUEST_ID),
     dtlegalization_date,
     TO_DATE(SBREGISTER_DATE, UT_DATE.FSBDATE_FORMAT),
     SBCOMMENTS,
     sysdate,
     pkGeneralServices.fsbGetUserName,
     pkGeneralServices.fsbGetTerminal,
     sbProg);

  COMMIT;

EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    ROLLBACK;
    RAISE EX.CONTROLLED_ERROR;
  WHEN OTHERS THEN
    ROLLBACK;
    ERRORS.SETERROR;
    RAISE EX.CONTROLLED_ERROR;
END LDCPROCESCAMBIOFELEOT;
/
PROMPT Otorgando permisos de ejecucion a LDCPROCESCAMBIOFELEOT
BEGIN
    pkg_utilidades.praplicarpermisos('LDCPROCESCAMBIOFELEOT', 'ADM_PERSON');
END;
/