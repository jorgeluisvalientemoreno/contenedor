CREATE OR REPLACE PROCEDURE ldc_notificaapronotcartera IS
/**************************************************************
  Propiedad intelectual PETI.

  Trigger  :  ldc_notificaapronotcartera

  Descripci¿n  : Envia las siguientes notificaciones:
               	 10002	APROBAR MONTO DE NOTAS POR AJUSTE	APROBAR NOTAS
                 12531	PROCESO INTERNO NOTAS AREA DE CARTERA
				 proceso interno notas area de cartera	Y	Y	Y	221	N	N	Y			N	99	N	N			B	N	MC	Y	Y	Y

  Autor  : John Jairo Jimenez Marimon
  Fecha  : 19-03-2013

  Historia de Modificaciones
  **************************************************************/

CURSOR cuunidadesotasig IS
 SELECT o2.operating_unit_id unidad_operativa,o.task_type_id tipo_trabajo,g.person_id,trim(g.e_mail) e_mail,count(1) cantidad
   FROM or_order o,or_operating_unit o2,ge_person g
  WHERE o.task_type_id      IN(dald_parameter.fnuGetNumeric_Value('COD_MONTO_NOT_AJUSTE_TT',NULL),dald_parameter.fnuGetNumeric_Value('COD_PROC_INT_NOT_CART_TT',NULL))
    AND o.order_status_id   = dald_parameter.fnuGetNumeric_Value('COD_ESTADO_ASIGNADA_OT',NULL)
    AND o.operating_unit_id = o2.operating_unit_id
    AND o2.person_in_charge = g.person_id
  GROUP BY o2.operating_unit_id,o.task_type_id,trim(g.e_mail);

CURSOR cuordenesnotifi(unid_oper NUMBER,tip_trab NUMBER) IS
 SELECT o.order_id orden
   FROM or_order o
  WHERE o.order_status_id   = dald_parameter.fnuGetNumeric_Value('COD_ESTADO_ASIGNADA_OT',NULL)
    AND o.task_type_id      = tip_trab
    AND o.operating_unit_id = unid_oper;

sbmensaot VARCHAR2(5000) DEFAULT NULL;
sbIssue   VARCHAR2(4000);
sbMessage VARCHAR2(4000);
nuErrCode NUMBER;
sbErrMsg  VARCHAR2(2000);
sbdesctit or_task_type.description%TYPE;
nuvarind  NUMBER(4);
BEGIN
 FOR i IN cuunidadesotasig LOOP
   sbmensaot := NULL;
   sbdesctit := NULL;
   BEGIN
    SELECT o.description INTO sbdesctit
      FROM or_task_type o
     WHERE o.task_type_id = i.tipo_trabajo;
   EXCEPTION
    WHEN OTHERS THEN
     sbdesctit := NULL;
   END;
   nuvarind := 0;
  FOR j IN cuordenesnotifi(i.unidad_operativa,i.tipo_trabajo) LOOP
   nuvarind := nuvarind + 1;
   IF nuvarind = 1 THEN
    sbmensaot := trim(to_char(j.orden));
   ELSE
    sbmensaot := trim(sbmensaot)||','||trim(to_char(j.orden));
   END IF;
  END LOOP;
  IF sbmensaot IS NOT NULL AND sbdesctit IS NOT NULL THEN
      sbIssue   := TRIM(sbdesctit);
      sbMessage := 'Se relacionan las ordenes que tiene asociada su unidad de trabajo para : '||sbmensaot;
      ldc_sendemail(i.e_mail,sbIssue,sbMessage);
  END IF;
 END LOOP;
EXCEPTION
 WHEN OTHERS THEN
  pkErrors.GetErrorVar(nuErrCode, sbErrMsg);
END;
/
