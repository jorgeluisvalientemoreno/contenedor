CREATE OR REPLACE PACKAGE adm_person.PKLDCPS IS
/*******************************************************************************
    Propiedad intelectual de CSC

    Paquete 	: PKLDCPS

    Descripcion	: Contiene el servicio para cambiar el estado de la solicitud cuando
    se encuentra en "En anulacion".

    Autor	   : Eduardo Cerón
    Fecha	   : 21/03/2019

    Historia de Modificaciones
    Fecha	ID Entrega
    Modificacion

*******************************************************************************/

/*******************************************************************************
    Propiedad intelectual de GDC
    Función 	: PROCESS
    Descripcion	: Procedimiento que realiza todo el proceso para cambiar el estado
    de la solicitud.
    *******************************************************************************/
PROCEDURE PROCESS;


END PKLDCPS;
/
CREATE OR REPLACE PACKAGE BODY adm_person.PKLDCPS IS
/*******************************************************************************
        Propiedad intelectual de CSC

        Función 	: VALIDATE_STATUS_PACKAGE

        Descripcion	: Función que valida si la solicitud ya se encuentra en estado
                      registrado.

        Autor	   : Eduardo Cerón
        Fecha	   : 21/03/2019

        Historia de Modificaciones
        Fecha	ID Entrega
        Modificacion

    *******************************************************************************/
FUNCTION VALIDATE_STATUS_PACKAGE(INUPACKAGE_ID IN MO_PACKAGES.package_id%TYPE)
RETURN NUMBER
IS

cursor curValidatePackage(inuPackage IN MO_PACKAGES.package_id%TYPE) is
    select motive_status_id
    from mo_packages
    where package_id = inuPackage;

nuStatus mo_packages.motive_status_id%type;

BEGIN

     OPEN curValidatePackage(INUPACKAGE_ID);
     FETCH curValidatePackage INTO nuStatus;
     CLOSE curValidatePackage;

     return nuStatus;

EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
              RAISE EX.CONTROLLED_ERROR;
        WHEN others THEN
              errors.seterror;
              RAISE EX.CONTROLLED_ERROR;

END VALIDATE_STATUS_PACKAGE;

/*******************************************************************************
        Propiedad intelectual de CSC

        Función 	: PROCESS

        Descripcion	: Procedimiento que realiza todo el proceso para cambiar el estado
                     de la solicitud.

        Autor	   : Eduardo Cerón
        Fecha	   : 21/03/2019

        Historia de Modificaciones
        Fecha	ID Entrega
        Modificacion

    *******************************************************************************/
PROCEDURE PROCESS IS
nuPackageId        MO_PACKAGES.package_id%TYPE;
nuPackageIdAnu        MO_PACKAGES.package_id%TYPE;

nuIteraccionSolanu  MO_PACKAGES.CUST_CARE_REQUES_NUM%TYPE;
	nuIteraccionSol    MO_PACKAGES.CUST_CARE_REQUES_NUM%TYPE;

cursor cuGetPackage(inuAdminAct IN MO_ADMIN_ACTIVITY.admin_activity_id%type) is
    select a.PACKAGE_ID, external_id
    from MO_ADMIN_ACTIVITY, Mo_Pack_Annul_Detail a
    where admin_activity_id = inuAdminAct
     and a.ANNUL_PACKAGE_ID = external_id;

   cursor cuDatosOrde IS
    select INITIAL_STATUS_ID, INITIAL_OPER_UNIT_ID, oa.order_id
    from Or_Order_Stat_Change c, or_order_Activity oa
    where c.order_id = oa.order_id
    and FINAL_STATUS_ID = 12
    and oa.package_id =nuPackageId ;

  cursor cuInstaciaSol(inusolicitud number) IS
  SELECT I.INSTANCE_ID, i.PARENT_ID
  FROM OPEN.WF_DATA_EXTERNAL p, open.wf_instance i
  where p.package_id = inusolicitud
    and p.PRODUCT_TYPE_TAG is null
    and p.PLAN_ID = i.PLAN_ID
    and i.STATUS_ID = 14;

  CURSOR cuInstanciaAnul IS
  SELECT I.INSTANCE_ID
  FROM OPEN.WF_DATA_EXTERNAL p, open.wf_instance i
  where p.package_id = nuPackageId
    and p.PRODUCT_TYPE_TAG is not null
    and p.PLAN_ID = i.PLAN_ID
    and i.STATUS_ID = 4;

	 CURSOR cuInstanciaAnulInt IS
  SELECT I.INSTANCE_ID
  FROM OPEN.WF_DATA_EXTERNAL p, open.wf_instance i
  where p.package_id = nuIteraccionSolanu
    and p.PLAN_ID = i.PLAN_ID
    and i.STATUS_ID = 4;

	nuAdminActivity ge_boInstanceControl.stysbValue;
	nuCommentType   ge_boInstanceControl.stysbValue;
	sbComment       ge_boInstanceControl.stysbValue;

	nuAdminActivitynew MO_ADMIN_ACTIVITY.admin_activity_id%type;
	nuCommentTypenew   GE_COMMENT_TYPE.comment_type_id%type;
	sbCommentnew       MO_COMMENT.comment_%type;


	nuStatus           NUMBER;
	sbTipoSoli         VARCHAR2(4000) :=  dald_parameter.fsbGetValue_Chain('LDC_TISOREVANUL',null);
	nuSolanul  NUMBER;

BEGIN
     ut_trace.trace('Inicia el metodo PKLDCPS.PROCESS',10);

     nuAdminActivity := ge_boInstanceControl.fsbGetFieldValue('MO_ADMIN_ACTIVITY', 'ADMIN_ACTIVITY_ID');
     nuCommentType := ge_boInstanceControl.fsbGetFieldValue('GE_COMMENT_TYPE', 'COMMENT_TYPE_ID');
     sbComment := ge_boInstanceControl.fsbGetFieldValue('MO_COMMENT', 'COMMENT_');

     ut_trace.trace('ID Proceso administrativo: '||nuAdminActivity||' Tipo comentario: '||nuCommentType||' Comentario: '||sbComment,10);

     IF nuAdminActivity IS NULL OR nuCommentType IS NULL OR sbComment IS NULL THEN

        ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error, 'Debe diligenciar todos los campos');
        raise ex.controlled_error;

     END IF;

     nuAdminActivitynew := TO_NUMBER(nuAdminActivity);
     nuCommentTypenew := TO_NUMBER(nuCommentType);
     sbCommentnew := TO_CHAR(sbComment);

     OPEN cuGetPackage(nuAdminActivitynew);
     FETCH cuGetPackage INTO nuPackageId, nuPackageIdAnu;
     CLOSE cuGetPackage;

     IF nuPackageId IS NULL THEN

        ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error, 'La solicitud tiene un valor nulo');
        raise ex.controlled_error;

     END IF;

	 SELECT COUNT(1) INTO nuSolanul
     FROM mo_packages P
	 WHERE p.package_type_id in ( select to_number(column_value)
								  from table(open.ldc_boutilities.splitstrings(sbTipoSoli, ',')))
		AND p.package_id = nuPackageId;

     ut_trace.trace('Numero de solicitud: '||nuPackageId,10);

     IF nuSolanul = 0 THEN
		 nuStatus := VALIDATE_STATUS_PACKAGE(nuPackageId);

		 IF nuStatus IS NOT NULL AND nuStatus = 36 THEN

			nuIteraccionSolanu := DAMO_PACKAGES.FSBGETCUST_CARE_REQUES_NUM(nuPackageIdAnu,null);
			nuIteraccionSol    := DAMO_PACKAGES.FSBGETCUST_CARE_REQUES_NUM(nuPackageId,null);

			UPDATE MO_PACKAGES
			SET MOTIVE_STATUS_ID = 13
			WHERE PACKAGE_ID = nuPackageId;

			UPDATE MO_MOTIVE
			SET MOTIVE_STATUS_ID = 1
			WHERE PACKAGE_ID = nuPackageId;

			UPDATE MO_COMPONENT
			SET MOTIVE_STATUS_ID = 15
			WHERE PACKAGE_ID = nuPackageId;

			INSERT INTO MO_COMMENT (COMMENT_ID,COMMENT_,MOTIVE_ID,COMMENT_TYPE_ID,PACKAGE_ID,REGISTER_DATE,PERSON_ID,ORGANIZAT_AREA_ID,LIMIT_RESPONSE_DATE,HISTOR_NAV_ID)
			VALUES(SEQ_MO_COMMENT.NEXTVAL,sbCommentnew,NULL,nuCommentTypenew,nuPackageId,SYSDATE,NULL,NULL,NULL,NULL);

			update MO_ADMIN_ACTIVITY set ATTENTION_DATE = sysdate   where admin_activity_id = nuAdminActivitynew;
			update mo_packages set MOTIVE_STATUS_ID = 14, ATTENTION_DATE = sysdate  where package_id = nuPackageIdAnu;
			update mo_motive set MOTIVE_STATUS_ID = 11 where package_id = nuPackageIdAnu;

			IF nuIteraccionSolanu <> nuIteraccionSol THEN
				UPDATE MO_PACKAGES
				SET MOTIVE_STATUS_ID = 13
				WHERE PACKAGE_ID = nuIteraccionSol;

				UPDATE MO_MOTIVE
				SET MOTIVE_STATUS_ID = 1
				WHERE PACKAGE_ID = nuIteraccionSol;

				UPDATE MO_COMPONENT
				SET MOTIVE_STATUS_ID = 15
				WHERE PACKAGE_ID = nuIteraccionSol;

			   UPDATE MO_PACKAGES
				SET MOTIVE_STATUS_ID = 14
			   WHERE PACKAGE_ID = nuIteraccionSolanu;

			   UPDATE MO_MOTIVE
				SET MOTIVE_STATUS_ID = 11
				WHERE PACKAGE_ID = nuIteraccionSolanu;


			END IF;

		   for reg in cuDatosOrde loop
			   update or_order set Order_Status_Id = reg.INITIAL_STATUS_ID, OPERATING_UNIT_ID = reg.INITIAL_OPER_UNIT_ID where order_id = reg.order_id;
			   update or_order_activity set status = 'R' WHERE order_id = reg.order_id;
			   UPDATE or_order_items SET LEGAL_ITEM_AMOUNT = 0 WHERE ORDER_ID = reg.order_id;
		   end loop;

       --se actualiza el flujo solicitud
	   FOR reg IN cuInstaciaSol(nuPackageId) LOOP
          UPDATE wf_instance set status_id = 4 where INSTANCE_ID = reg.INSTANCE_ID;
		  UPDATE wf_instance set status_id = 4 where INSTANCE_ID = reg.PARENT_ID;
		  UPDATE wf_instance_trans ff   SET    ff.status = 1  WHERE  ff.origin_id = reg.INSTANCE_ID;

       END LOOP;
	   --se actualiza el flujo solicitud
	  FOR reg IN cuInstaciaSol(nuIteraccionSol) LOOP
		  UPDATE wf_instance set status_id = 4, FINAL_DATE = null where INSTANCE_ID = reg.INSTANCE_ID;
		  UPDATE wf_instance set status_id = 4 where INSTANCE_ID = reg.PARENT_ID;
		  UPDATE wf_instance_trans ff   SET  ff.status = 1  WHERE  ff.origin_id = reg.INSTANCE_ID;
		  UPDATE WF_INSTANCE_ATTRIB SET VALUE = NULL Where INSTANCE_ID = reg.INSTANCE_ID;


	  END LOOP;

	  mo_bowf_pack_interfac.PrepNotToWfPack(nuIteraccionSol,
                                              289,
                                              MO_BOCausal.fnuGetsuccess,
                                              3,
                                              FALSE);

       FOR reg IN cuInstanciaAnul LOOP
          UPDATE wf_instance set status_id = 14 where INSTANCE_ID = reg.INSTANCE_ID;
       END LOOP;

      IF nuIteraccionSolanu <> nuIteraccionSol THEN
         FOR reg IN cuInstanciaAnulInt LOOP
              UPDATE wf_instance set status_id = 14 where INSTANCE_ID = reg.INSTANCE_ID;
           END LOOP;
       END IF;

		 END IF;
	  else
			ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error, 'Este proceso no esta permitido para este tipo de solicitud. Por favor validar parametro LDC_TISOREVANUL en LDPAR.');
			raise ex.controlled_error;
	  END IF;
      COMMIT;
     ut_trace.trace('Fin del procedimiento PKLDCPS.PROCESS',10);

EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
              RAISE EX.CONTROLLED_ERROR;
        WHEN others THEN
              errors.seterror;
              RAISE EX.CONTROLLED_ERROR;

END PROCESS;


END PKLDCPS;
/
PROMPT Otorgando permisos de ejecucion a PKLDCPS
BEGIN
    pkg_utilidades.praplicarpermisos('PKLDCPS', 'ADM_PERSON');
END;
/