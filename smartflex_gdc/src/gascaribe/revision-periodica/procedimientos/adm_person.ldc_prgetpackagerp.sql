CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_PRGETPACKAGERP(INUPACKAGE IN NUMBER,
                                               OCUCURSOR  OUT CONSTANTS.TYREFCURSOR) IS
  /***********************************************************************************************************
  Propiedad Intelectual de Gases del Caribe S.A E.S.P

   Funcion     : LDC_PRGETPACKAGERP
   Descripcion : Procedimiento que muestra las solicitudes asociadas al producto en la pestaña
                 Solicitudes de revision periodica en CNCRM.
   Autor       : Sebastian Tapias
   Fecha       : 16/01/2018

   Historia de Modificaciones
     Fecha               Autor                Modificacion
   =========           =========          ====================
   16-01-2018        CASO - 2001518       Creacion del servicio.
  ************************************************************************************************************/
  SBPACKAGEATTRIBUTES VARCHAR2(32767);
  SBPACKAGEFROM       VARCHAR2(6000);
  SBPACKAGEWHERE      VARCHAR2(6000);
  SBPACKAGEWHEREADD   VARCHAR2(6000);
  SBPACKAGETYPE       VARCHAR2(300);
  SBPACKAGESTATUS     VARCHAR2(300);
  SBRECEPTIONTYPE     VARCHAR2(300);
  SBVENDOR            VARCHAR2(300);
  SBNEIGHBORTHOOD     VARCHAR2(300);
  SBSUBSCRIBER        VARCHAR2(300);
  SBORGANIZAT_AREA    VARCHAR2(300);
  SBMANAGEMENT_AREA   VARCHAR2(300);
  SBOPERUNITPOS       VARCHAR2(300);
  SBCAMPAIGN          VARCHAR2(300);
  SBANSWERMODE        VARCHAR2(300);
  SBREFERMODE         VARCHAR2(300);
  SBCONTACT           VARCHAR2(300);
  SBFORMTYPE          VARCHAR2(300);
  SBADDRESS           VARCHAR2(300);
  SBADD_GEO_LOC_ID    VARCHAR2(300);
  SBADD_NEIGHBOR_ID   VARCHAR2(300);
  SBCHANGE_DETAIL     VARCHAR2(300);
  SBLIQUIDATIONMETHOD VARCHAR2(300);
  SBSQL               VARCHAR2(32767);
  SBPACKAGEHINTS      VARCHAR2(6000);

BEGIN
  UT_TRACE.TRACE('LDC_PRGETPACKAGERP: INICIO', 1);
  UT_TRACE.TRACE('INUPACKAGE: [' || INUPACKAGE || ']', 1);

  CC_BOOSSPACKAGEDATA.INIT;

  IF SBPACKAGEATTRIBUTES IS NOT NULL THEN
    RETURN;
  END IF;

  SBSUBSCRIBER      := 'a.subscriber_id' || CC_BOBOSSUTIL.CSBSEPARATOR ||
                       'r.subscriber_name||'' ''||r.subs_last_name';
  SBPACKAGETYPE     := 'a.package_type_id' || CC_BOBOSSUTIL.CSBSEPARATOR ||
                       'b.description';
  SBPACKAGESTATUS   := 'a.motive_status_id' || CC_BOBOSSUTIL.CSBSEPARATOR ||
                       'c.description';
  SBRECEPTIONTYPE   := 'a.reception_type_id' || CC_BOBOSSUTIL.CSBSEPARATOR ||
                       'e.description';
  SBVENDOR          := 'a.person_id' || CC_BOBOSSUTIL.CSBSEPARATOR ||
                       'f.name_';
  SBORGANIZAT_AREA  := 'a.organizat_area_id' || CC_BOBOSSUTIL.CSBSEPARATOR ||
                       'g.display_description';
  SBMANAGEMENT_AREA := 'a.management_area_id' || CC_BOBOSSUTIL.CSBSEPARATOR ||
                       't.display_description';
  SBOPERUNITPOS     := 'a.POS_Oper_Unit_Id' || CC_BOBOSSUTIL.CSBSEPARATOR ||
                       'k.name';
  SBCAMPAIGN        := 'a.Project_Id' || CC_BOBOSSUTIL.CSBSEPARATOR ||
                       'l.project_description';

  SBNEIGHBORTHOOD := 'u.geograp_location_id' || CC_BOBOSSUTIL.CSBSEPARATOR ||
                     'u.description';

  SBADDRESS         := 'cc_boOssPackageData.fsbGetAddress(a.package_id)';
  SBADD_GEO_LOC_ID  := 'cc_boOssPackageData.fsbAddressGeoLoc(a.package_id)';
  SBADD_NEIGHBOR_ID := 'cc_boOssPackageData.fsbAddressNeighbor(a.package_id)';

  SBCHANGE_DETAIL := 'cc_boOssPackageData.fsbGetPackChanDetail(a.package_id, a.package_type_id)';

  SBANSWERMODE := 'a.answer_mode_id' || CC_BOBOSSUTIL.CSBSEPARATOR ||
                  'm.description';
  SBREFERMODE  := 'a.refer_mode_id' || CC_BOBOSSUTIL.CSBSEPARATOR ||
                  'n.description';
  SBCONTACT    := 'a.contact_id' || CC_BOBOSSUTIL.CSBSEPARATOR ||
                  'o.subscriber_name||'' ''||o.subs_last_name';
  SBFORMTYPE   := 'a.document_type_id' || CC_BOBOSSUTIL.CSBSEPARATOR ||
                  'q.ticodesc';

  SBLIQUIDATIONMETHOD := 'decode(a.liquidation_method, null, b.liquidation_method, a.liquidation_method)' ||
                         CC_BOBOSSUTIL.CSBSEPARATOR ||
                         ' cc_boquotationutil.fsbGetLiquidMethod(decode(a.liquidation_method, null, b.liquidation_method, a.liquidation_method))';

  CC_BOBOSSUTIL.ADDATTRIBUTE('a.package_id',
                             'package_id',
                             SBPACKAGEATTRIBUTES);
  CC_BOBOSSUTIL.ADDATTRIBUTE(SBSUBSCRIBER,
                             'subscriber',
                             SBPACKAGEATTRIBUTES);
  CC_BOBOSSUTIL.ADDATTRIBUTE(SBPACKAGETYPE,
                             'package_type',
                             SBPACKAGEATTRIBUTES);
  CC_BOBOSSUTIL.ADDATTRIBUTE('a.package_type_id',
                             'package_type_id',
                             SBPACKAGEATTRIBUTES);
  CC_BOBOSSUTIL.ADDATTRIBUTE('a.request_date',
                             'request_date',
                             SBPACKAGEATTRIBUTES);
  CC_BOBOSSUTIL.ADDATTRIBUTE('a.Expect_Atten_Date',
                             'Expect_Atten_Date',
                             SBPACKAGEATTRIBUTES);
  CC_BOBOSSUTIL.ADDATTRIBUTE(SBPACKAGESTATUS,
                             'package_status',
                             SBPACKAGEATTRIBUTES);
  CC_BOBOSSUTIL.ADDATTRIBUTE('a.user_id', 'user_id', SBPACKAGEATTRIBUTES);
  CC_BOBOSSUTIL.ADDATTRIBUTE('a.attention_date',
                             'attention_date',
                             SBPACKAGEATTRIBUTES);
  CC_BOBOSSUTIL.ADDATTRIBUTE('a.comment_', 'comment_', SBPACKAGEATTRIBUTES);
  CC_BOBOSSUTIL.ADDATTRIBUTE(SBRECEPTIONTYPE,
                             'reception_type',
                             SBPACKAGEATTRIBUTES);
  CC_BOBOSSUTIL.ADDATTRIBUTE(SBVENDOR, 'vendor', SBPACKAGEATTRIBUTES);
  CC_BOBOSSUTIL.ADDATTRIBUTE(SBORGANIZAT_AREA,
                             'organizat_area_id',
                             SBPACKAGEATTRIBUTES);
  CC_BOBOSSUTIL.ADDATTRIBUTE(SBMANAGEMENT_AREA,
                             'management_area',
                             SBPACKAGEATTRIBUTES);
  CC_BOBOSSUTIL.ADDATTRIBUTE('a.number_of_prod',
                             'number_of_prod',
                             SBPACKAGEATTRIBUTES);
  CC_BOBOSSUTIL.ADDATTRIBUTE('s.address_parsed',
                             'client_address',
                             SBPACKAGEATTRIBUTES);
  CC_BOBOSSUTIL.ADDATTRIBUTE(SBNEIGHBORTHOOD,
                             'client_neighborthood',
                             SBPACKAGEATTRIBUTES);
  CC_BOBOSSUTIL.ADDATTRIBUTE('o.phone',
                             'contact_phone_number',
                             SBPACKAGEATTRIBUTES);
  CC_BOBOSSUTIL.ADDATTRIBUTE('a.cust_care_reques_num',
                             'cust_care_reques_num',
                             SBPACKAGEATTRIBUTES);
  CC_BOBOSSUTIL.ADDATTRIBUTE(SBOPERUNITPOS,
                             'POS_Oper_Unit_Id',
                             SBPACKAGEATTRIBUTES);
  CC_BOBOSSUTIL.ADDATTRIBUTE(SBCAMPAIGN, 'Project_Id', SBPACKAGEATTRIBUTES);

  CC_BOBOSSUTIL.ADDATTRIBUTE(SBADDRESS, 'address', SBPACKAGEATTRIBUTES);
  CC_BOBOSSUTIL.ADDATTRIBUTE(SBADD_GEO_LOC_ID,
                             'add_geo_loc_id',
                             SBPACKAGEATTRIBUTES);
  CC_BOBOSSUTIL.ADDATTRIBUTE(SBADD_NEIGHBOR_ID,
                             'add_neighbor_id',
                             SBPACKAGEATTRIBUTES);

  CC_BOBOSSUTIL.ADDATTRIBUTE(SBCHANGE_DETAIL,
                             'change_detail',
                             SBPACKAGEATTRIBUTES);

  CC_BOBOSSUTIL.ADDATTRIBUTE(SBANSWERMODE,
                             'answer_mode',
                             SBPACKAGEATTRIBUTES);
  CC_BOBOSSUTIL.ADDATTRIBUTE(SBREFERMODE,
                             'refer_mode',
                             SBPACKAGEATTRIBUTES);
  CC_BOBOSSUTIL.ADDATTRIBUTE(SBCONTACT, 'contact', SBPACKAGEATTRIBUTES);
  CC_BOBOSSUTIL.ADDATTRIBUTE('p.address_parsed',
                             'answer_address',
                             SBPACKAGEATTRIBUTES);

  CC_BOBOSSUTIL.ADDATTRIBUTE('a.document_key',
                             'form_number',
                             SBPACKAGEATTRIBUTES);
  CC_BOBOSSUTIL.ADDATTRIBUTE(SBFORMTYPE, 'form_type', SBPACKAGEATTRIBUTES);

  CC_BOBOSSUTIL.ADDATTRIBUTE(SBLIQUIDATIONMETHOD,
                             'liquidation_method',
                             SBPACKAGEATTRIBUTES);

  CC_BOBOSSUTIL.ADDATTRIBUTE(':parent_id',
                             'parent_id',
                             SBPACKAGEATTRIBUTES);

  SBPACKAGEFROM := 'mo_packages a, ps_package_type b, ps_motive_status c,' ||
                   CHR(10) ||
                   'ge_reception_type e, ge_person f, ge_organizat_area g,' ||
                   CHR(10) ||
                   'or_operating_unit k, pm_project l, cc_answer_mode m,' ||
                   CHR(10) ||
                   'cc_refer_mode n, ge_subscriber o, ab_Address p,' ||
                   CHR(10) || 'tipocomp q, ge_subscriber r, ab_address s,' ||
                   CHR(10) || 'ge_organizat_area t, ge_geogra_location u';

  SBPACKAGEWHERE := 'a.package_type_id = b.package_type_id' || CHR(10) ||
                    'AND a.motive_status_id = c.motive_status_id' ||
                    CHR(10) ||
                    'AND a.reception_type_id = e.reception_type_id (+)' ||
                    CHR(10) || 'AND a.person_id = f.person_id (+)' ||
                    CHR(10) ||
                    'AND a.organizat_area_id = g.organizat_area_id (+)' ||
                    CHR(10) ||
                    'AND a.management_area_id = t.organizat_area_id (+)' ||
                    CHR(10) || 'AND a.subscriber_id = r.subscriber_id (+)' ||
                    CHR(10) || 'AND r.address_id = s.address_id (+)' ||
                    CHR(10) ||
                    'AND s.neighborthood_id = u.geograp_location_id (+)' ||
                    CHR(10) ||
                    'AND a.POS_Oper_Unit_Id = k.operating_unit_id (+)' ||
                    CHR(10) || 'AND a.Project_Id = l.Project_Id (+)' ||
                    CHR(10) ||
                    'AND a.answer_mode_id = m.answer_mode_id (+)' ||
                    CHR(10) || 'AND a.refer_mode_id = n.refer_mode_id (+)' ||
                    CHR(10) || 'AND a.contact_id = o.subscriber_id (+)' ||
                    CHR(10) || 'AND a.address_id = p.address_id (+)' ||
                    CHR(10) || 'AND a.document_type_id = q.ticocodi (+)' ||
                    CHR(10) ||
                    'AND a.package_type_id in (select nvl(to_number(column_value), 0)
          from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain(''ID_PACKAGE_TYPE_REVI_RP'',
                                                                                   NULL),
                                                  '','')))' ||
                    CHR(10) ||
                    'AND a.package_id in (SELECT mt.package_id FROM mo_motive mt WHERE mt.product_id = :Package)';

  SBPACKAGEHINTS := '/*+ leading (a) use_nl(a b) use_nl(a c) use_nl(a e)' ||
                    CHR(10) ||
                    'use_nl(a f) use_nl(a g) use_nl(a r) use_nl(r s)' ||
                    CHR(10) ||
                    'use_nl(a k) use_nl(a l) use_nl(a m) use_nl(a n)' ||
                    CHR(10) ||
                    'use_nl(a o) use_nl(a p) use_nl(a q) use_nl(s u)' ||
                    CHR(10) ||
                    'index (a PK_MO_PACKAGES) index (f PK_GE_PERSON)' ||
                    CHR(10) ||
                    'index (g PK_GE_ORGANIZAT_AREA) index (r PK_GE_SUBSCRIBER)' ||
                    CHR(10) ||
                    'index (s PK_AB_ADDRESS) index (k PK_OR_OPERATING_UNIT)' ||
                    CHR(10) ||
                    'index (l PK_PM_PROJECT) index (o PK_GE_SUBSCRIBER)' ||
                    CHR(10) ||
                    'index (p PK_AB_ADDRESS) index (u PK_GE_GEOGRA_LOCATION)*/';

  /*SBSQL := 'SELECT ' || SBPACKAGEHINTS || CHR(10) || SBPACKAGEATTRIBUTES ||
           CHR(10) || 'FROM ' || SBPACKAGEFROM || CHR(10) || 'WHERE ' ||
           SBPACKAGEWHERE;*/

  SBSQL := 'SELECT ' /*|| SBPACKAGEHINTS || CHR(10)*/ || SBPACKAGEATTRIBUTES ||
           CHR(10) || 'FROM ' || SBPACKAGEFROM || CHR(10) || 'WHERE ' ||
           SBPACKAGEWHERE;

  UT_TRACE.TRACE('Consulta: [' || SBSQL || ']', 1);
  dbms_output.put_line(SBSQL);

  OPEN OCUCURSOR FOR SBSQL
    USING INUPACKAGE, INUPACKAGE;

  UT_TRACE.TRACE('LDC_PRGETPACKAGERP: FIN', 1);

EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    RAISE EX.CONTROLLED_ERROR;

  WHEN OTHERS THEN
    ERRORS.SETERROR;
    RAISE EX.CONTROLLED_ERROR;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PRGETPACKAGERP', 'ADM_PERSON');
END;
/
