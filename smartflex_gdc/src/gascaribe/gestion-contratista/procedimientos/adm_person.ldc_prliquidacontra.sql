create or replace PROCEDURE ADM_PERSON.LDC_PRLIQUIDACONTRA
IS
  /**************************************************************************

  UNIDAD      :  LDC_PRLIQUIDACONTRA
  Descripcion :  Registra novedad de liquidacion de contratista
  Autor       :  Antonio Benitez Llorente / Miguel Angel Ballesteros G
  Fecha       :  24-09-2019

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
	12/02/2020         HORBATH             CASO 625: Se modifica el llamado CT_BONOVELTY.CREATENOVELTY
  **************************************************************************/
cnuNULL_ATTRIBUTE constant number := 2126;
isbNumeroCaso varchar2(30):='0000052';

sbID_CONTRATISTA ge_boInstanceControl.stysbValue;
sbOPERATING_UNIT_ID ge_boInstanceControl.stysbValue;
sbID_TIPO_CONTRATO ge_boInstanceControl.stysbValue;
sbID_CONTRATO ge_boInstanceControl.stysbValue;
sbFIGURE_TYPE_ID ge_boInstanceControl.stysbValue;
sbPERSON_ID ge_boInstanceControl.stysbValue;
sbITEMS_ID ge_boInstanceControl.stysbValue;
sbORDER_ID ge_boInstanceControl.stysbValue;
sbADDRESS_ID ge_boInstanceControl.stysbValue;
sbGEOGRAP_LOCATION_ID ge_boInstanceControl.stysbValue;
sbVALOR ge_boInstanceControl.stysbValue;
sbINDICATOR_VALUE ge_boInstanceControl.stysbValue;
sbCOMMENT_TYPE_ID ge_boInstanceControl.stysbValue;
sbDESCRIPTION ge_boInstanceControl.stysbValue;
NUORDER       or_order.order_id%type;
nuUsuario     sa_user.user_id%type;
nuID_CONTRATO  ge_contrato.id_contrato%TYPE; -- caso:625

BEGIN
    IF fblAplicaEntregaxCaso(isbNumeroCaso)THEN
    sbID_CONTRATISTA := ut_convert.fnuchartonumber(ge_boInstanceControl.fsbGetFieldValue ('GE_CONTRATISTA', 'ID_CONTRATISTA'));
    sbOPERATING_UNIT_ID := ut_convert.fnuchartonumber(ge_boInstanceControl.fsbGetFieldValue ('OR_OPERATING_UNIT', 'OPERATING_UNIT_ID'));
    sbID_TIPO_CONTRATO := ut_convert.fnuchartonumber(ge_boInstanceControl.fsbGetFieldValue ('GE_TIPO_CONTRATO', 'ID_TIPO_CONTRATO'));
    sbID_CONTRATO := ut_convert.fnuchartonumber(ge_boInstanceControl.fsbGetFieldValue ('GE_CONTRATO', 'ID_CONTRATO'));
    sbFIGURE_TYPE_ID := ut_convert.fnuchartonumber(ge_boInstanceControl.fsbGetFieldValue ('GE_FIGURE_TYPE', 'FIGURE_TYPE_ID'));
    sbPERSON_ID := ut_convert.fnuchartonumber(ge_boInstanceControl.fsbGetFieldValue ('GE_PERSON', 'PERSON_ID'));
    sbITEMS_ID := ut_convert.fnuchartonumber(ge_boInstanceControl.fsbGetFieldValue ('CT_ITEM_NOVELTY', 'ITEMS_ID'));
    sbORDER_ID := ut_convert.fnuchartonumber(ge_boInstanceControl.fsbGetFieldValue ('OR_ORDER', 'ORDER_ID'));
	sbADDRESS_ID := ut_convert.fnuchartonumber(ge_boInstanceControl.fsbGetFieldValue ('AB_ADDRESS', 'GEOGRAP_LOCATION_ID'));
    sbGEOGRAP_LOCATION_ID := open.daab_address.fnugetgeograp_location_id(ut_convert.fnuchartonumber(ge_boInstanceControl.fsbGetFieldValue ('AB_ADDRESS', 'GEOGRAP_LOCATION_ID')));
	sbVALOR := ut_convert.fnuchartonumber(ge_boInstanceControl.fsbGetFieldValue ('GE_ITEMS_TIPO_AT_VAL', 'VALOR'));
    sbINDICATOR_VALUE := ut_convert.fnuchartonumber(ge_boInstanceControl.fsbGetFieldValue ('GE_DETALLE_ACTA', 'CANTIDAD'));
    sbCOMMENT_TYPE_ID := ut_convert.fnuchartonumber(ge_boInstanceControl.fsbGetFieldValue ('GE_COMMENT_TYPE', 'COMMENT_TYPE_ID'));
    sbDESCRIPTION := ge_boInstanceControl.fsbGetFieldValue ('GE_DETALLE_ACTA', 'DESCRIPCION_ITEMS');

    ------------------------------------------------
    -- Required Attributes
    ------------------------------------------------

    if (sbOPERATING_UNIT_ID is null) then
        Errors.SetError (cnuNULL_ATTRIBUTE, 'Unidad de Trabajo');
        raise ex.CONTROLLED_ERROR;
    end if;

    if (sbID_CONTRATO is null) then
        Errors.SetError (cnuNULL_ATTRIBUTE, 'Contrato');
        raise ex.CONTROLLED_ERROR;
    end if;

    if (sbCOMMENT_TYPE_ID is null) then
        Errors.SetError (cnuNULL_ATTRIBUTE, 'Tipo observaci¿n');
        raise ex.CONTROLLED_ERROR;
    end if;

    if (sbID_TIPO_CONTRATO is null) then
        Errors.SetError (cnuNULL_ATTRIBUTE, 'Tipo de contrato');
        raise ex.CONTROLLED_ERROR;
    end if;

    if (sbFIGURE_TYPE_ID is null) then
        Errors.SetError (cnuNULL_ATTRIBUTE, 'Tipo de novedad');
        raise ex.CONTROLLED_ERROR;
    end if;

	nuID_CONTRATO := to_number(sbID_CONTRATO); -- caso:625

    CT_BONOVELTY.CREATENOVELTY(
           INUCONTRACTOR => NULL,
           INUOPERUNIT   => sbOPERATING_UNIT_ID,
           INUITEM       => sbITEMS_ID,
           INUTECUNIT    => sbPERSON_ID,
           INUORDERID    => sbORDER_ID,
           INUVALUE      => sbINDICATOR_VALUE,
           INUAMOUNT     => sbVALOR,
           INUUSERID     => nuUsuario,
           INUCOMMENTYPE => sbCOMMENT_TYPE_ID,
           ISBCOMMENT    => sbDESCRIPTION,
           ONUORDER      => NUORDER,
		   INUCONTRACT   => nuID_CONTRATO -- caso:625
           );

     IF (sbGEOGRAP_LOCATION_ID IS NOT NULL) THEN
       -- se actualiza la localidad de la orden
	   UPDATE OR_ORDER
       SET GEOGRAP_LOCATION_ID = sbGEOGRAP_LOCATION_ID,
	   EXTERNAL_ADDRESS_ID = sbADDRESS_ID
       WHERE ORDER_ID = NUORDER;

	   -- se actualiza la direccion de la orden
	   UPDATE OR_ORDER_ACTIVITY
	   SET ADDRESS_ID = sbADDRESS_ID
	   WHERE ORDER_ID = NUORDER;

	   UPDATE OR_EXTERN_SYSTEMS_ID
	      SET ADDRESS_ID=sbADDRESS_ID
		WHERE ORDER_ID=NUORDER;
     END IF;

     COMMIT;

     END IF;

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise;

    when OTHERS then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PRLIQUIDACONTRA', 'ADM_PERSON');
END;
/
