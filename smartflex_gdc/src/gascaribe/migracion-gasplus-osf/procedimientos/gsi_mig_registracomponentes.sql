CREATE OR REPLACE PROCEDURE      "GSI_MIG_REGISTRACOMPONENTES" (
   inuproductid             IN     pr_component.product_id%TYPE,
   inucomponenttypeid       IN     pr_component.component_type_id%TYPE,
   inuclassserviceid        IN     pr_component.class_service_id%TYPE,
   isbservicenumber         IN     pr_component.service_number%TYPE,
   idtcreationdate          IN     pr_component.service_date%TYPE,
   idtretiredate            IN     compsesu.cmssfere%TYPE,
   inuquantity              IN     pr_component.quantity%TYPE,
   inuunchargedtime         IN     pr_component.uncharged_time%TYPE,
   isbdirectionality        IN     pr_component.directionality_id%TYPE,
   inucategory_id           IN     pr_component.category_id%TYPE,
   inusubcategory_id        IN     pr_component.subcategory_id%TYPE,
   inudistributadminid      IN     pr_component.distribut_admin_id%TYPE,
   inumeter                 IN     pr_component.meter%TYPE,
   inubuildingid            IN     pr_component.building_id%TYPE,
   inuassignrouteid         IN     pr_component.assign_route_id%TYPE,
   inuparentcomp            IN     pr_component.component_id%TYPE,
   isbdistrictid            IN     pr_component.district_id%TYPE DEFAULT NULL,
   isbincluido              IN     pr_component.is_included%TYPE,
   inuaddressid             IN     ab_address.address_id%TYPE,
   inugeograp_location_id   IN     ab_address.geograp_location_id%TYPE,
   inuneighborthood_id      IN     ab_address.neighborthood_id%TYPE,
   isbaddress               IN     ab_address.address%TYPE,
   inuproductorigin         IN     pr_component.product_origin_id%TYPE,
   inuincludedfeatures      IN     pr_component.included_features_id%TYPE,
   inucomponent_status      IN     pr_component.component_status_id%TYPE,
   isbmain                  IN     pr_component.is_main%TYPE,
   ionucomponentid          IN OUT pr_component.component_id%TYPE,
   onuerrorcode                OUT ge_message.message_id%TYPE,
   osberrormessage             OUT VARCHAR2)
IS
   /*
    Nombre objeto      gsi_mig_registracomponentes
    Proposito          Creacion de componentes en las tablas, compsesu, pr_component y pr_component_link.

    Historial
    Fecha           Modificacion        Autor
    2012-01-31      Creacion            Wospina
    2012-11-28      Modificacion        Wospina:
                                        Modificacion por cambio de esquema:
                                        - PR_COMPONENT.SOCIOECONO_STRAT_ID  Se elimina del APi.
                                        - PR_COMPONENT.CATEGORY_ID          Se adicional como parametro
                                        - PR_COMPONENT.SUBCATEGORY_ID       Se adicional como parametro
    2013-04-02                          PDELAPENA: Se agrega el parametro de entrada isbmain debido a no estaba siendo utilizado
                                                   Se llena el  parametro de salida con la descripción del error de
                                                   oracle para el caso de errores no controlados osberrormessage:=SQLERRM;
   */
   -- Para Compsesu
   nucmssidco               compsesu.cmssidco%TYPE;
   nucmsssesu               compsesu.cmsssesu%TYPE;
   dtcmssfein               compsesu.cmssfein%TYPE;
   dtcmssfere               compsesu.cmssfere%TYPE;
   nucmssescm               compsesu.cmssescm%TYPE;
   sbcmssdaad               compsesu.cmssdaad%TYPE;
   nucmssclse               compsesu.cmssclse%TYPE;
   nucmsstcom               compsesu.cmsstcom%TYPE;
   nucmssidcp               compsesu.cmssidcp%TYPE;
   sbcmsscouc               compsesu.cmsscouc%TYPE;
   nucmsstifs               compsesu.cmsstifs%TYPE;
   nucmssdigr               compsesu.cmssdigr%TYPE;
   nucmsssspr               compsesu.cmsssspr%TYPE;
   nucmsscant               compsesu.cmsscant%TYPE;
   sbcmssincl               compsesu.cmssincl%TYPE;
   nucmssplco               compsesu.cmssplco%TYPE;
   sbcmssmain               compsesu.cmssmain%TYPE;

   -- Para Pr_Component

   nucomponent_id           pr_component.component_id%TYPE;
   sbservice_number         pr_component.service_number%TYPE;
   nucomponent_type_id      pr_component.component_type_id%TYPE;
   nuproduct_id             pr_component.product_id%TYPE;
   sbis_inconsistent        pr_component.is_inconsistent%TYPE;
   sbinstall_direct_id      pr_component.install_direct_id%TYPE;
   sbdirectionality_id      pr_component.directionality_id%TYPE;
   nucomponent_status_id    pr_component.component_status_id%TYPE;
   numeter                  pr_component.meter%TYPE;
   sbdistrict_id            pr_component.district_id%TYPE;
   nubuilding_id            pr_component.building_id%TYPE;
   dtcreation_date          pr_component.creation_date%TYPE;
   dtlast_upd_date          pr_component.last_upd_date%TYPE;
   --nusocioecono_strat_id    pr_component.socioecono_strat_id%TYPE;
   nuassign_route_id        pr_component.assign_route_id%TYPE;
   nuclass_service_id       pr_component.class_service_id%TYPE;
   nudistribut_admin_id     pr_component.distribut_admin_id%TYPE;
   dtservice_date           pr_component.service_date%TYPE;
   dtmediation_date         pr_component.mediation_date%TYPE;
   nuuncharged_time         pr_component.uncharged_time%TYPE;
   nuproduct_origin_id      pr_component.product_origin_id%TYPE;
   nuquantity               pr_component.quantity%TYPE;
   nuincluded_features_id   pr_component.included_features_id%TYPE;
   sbis_included            pr_component.is_included%TYPE;
   sbis_main                pr_component.is_main%TYPE;
   nucommercial_plan_id     pr_component.commercial_plan_id%TYPE;
   nuaddress_id             pr_component.address_id%TYPE;
   nucomp_prod_prov_id      pr_component.comp_prod_prov_id%TYPE;
   nucategory_id            pr_component.category_id%TYPE;
   nusubcategory_id         pr_component.subcategory_id%TYPE;


   -- Para Pr_Component_Link.
   nucomponent_link_id      pr_component_link.component_link_id%TYPE;
   nuparent_component_id    pr_component_link.parent_component_id%TYPE;
   nuchild_component_id     pr_component_link.child_component_id%TYPE;

BEGIN
   ----------------------------------- CompSesu

   IF (ionucomponentid IS NULL)
   THEN
      ionucomponentid :=
         pkgeneralservices.fnugetnextsequenceval ('SEQ_PR_COMPONENT');
   END IF;
   
   nucmssidco := ionucomponentid;
   nucmsssesu := inuproductid;
   dtcmssfein := idtcreationdate;
   dtcmssfere := idtretiredate;
   nucmssescm := inucomponent_status;
   sbcmssdaad := NULL;
   nucmssclse := inuclassserviceid;
   nucmsstcom := inucomponenttypeid;
   nucmssidcp := inuparentcomp;
   sbcmsscouc := nucmssidco;
   nucmsstifs := NULL;
   nucmssdigr := 0;
   nucmsssspr := inuproductid;
   nucmsscant := inuquantity;
   sbcmssincl := inuincludedfeatures;
   nucmssplco := NULL;
   sbcmssmain := isbmain;
   ----------------------------------- Pr_Component
   nucomponent_id := nucmssidco;
   sbservice_number := isbservicenumber;
   nucomponent_type_id := inucomponenttypeid;
   nuproduct_id := inuproductid;
   sbis_inconsistent := 'N';
   sbinstall_direct_id := 'BI';
   sbdirectionality_id := isbdirectionality;
   nucomponent_status_id := inucomponent_status;
   numeter := inumeter;
   sbdistrict_id := NULL;
   nubuilding_id := NULL;
   dtcreation_date := idtcreationdate;
   dtlast_upd_date := idtcreationdate;
   --nusocioecono_strat_id := inusocioeconostratid;
   nucategory_id := inucategory_id;
   nusubcategory_id := nusubcategory_id;
   nuassign_route_id := inuassignrouteid;
   nuclass_service_id := inuclassserviceid;
   nudistribut_admin_id := inudistributadminid;
   dtservice_date := idtcreationdate;
   dtmediation_date := idtcreationdate;
   nuuncharged_time := inuunchargedtime;
   nuproduct_origin_id := inuproductorigin;
   nuquantity := inuquantity;
   nuincluded_features_id := inuincludedfeatures;
   sbis_included := isbincluido;
   sbis_main := isbmain;
   nucommercial_plan_id := NULL;
   nuaddress_id := inuaddressid;
   nucomp_prod_prov_id := NULL;
   ----------------------------------- Pr_Component_link



   nucomponent_link_id :=
      pkgeneralservices.fnugetnextsequenceval ('SEQ_PR_COMPONENT_LINK');
   nuparent_component_id := inuparentcomp;
   nuchild_component_id := nucmssidco;

   --<------------------------------------------------------------------------------>
   -- Codigo viejo

   INSERT INTO compsesu
        VALUES (nucmssidco,
                nucmsssesu,
                dtcmssfein,
                dtcmssfere,
                nucmssescm,
                sbcmssdaad,
                nucmssclse,
                nucmsstcom,
                nucmssidcp,
                sbcmsscouc,
                nucmsstifs,
                nucmssdigr,
                nucmsssspr,
                nucmsscant,
                sbcmssincl,
                nucmssplco,
                sbcmssmain);

   INSERT INTO pr_component
        VALUES (nucomponent_id,
                sbservice_number,
                nucomponent_type_id,
                nuproduct_id,
                sbis_inconsistent,
                sbinstall_direct_id,
                sbdirectionality_id,
                nucomponent_status_id,
                numeter,
                sbdistrict_id,
                nubuilding_id,
                dtcreation_date,
                dtlast_upd_date,
                --nusocioecono_strat_id,
                nuassign_route_id,
                nuclass_service_id,
                nudistribut_admin_id,
                dtservice_date,
                dtmediation_date,
                nuuncharged_time,
                nuproduct_origin_id,
                nuquantity,
                nuincluded_features_id,
                sbis_included,
                sbis_main,
                nucommercial_plan_id,
                nuaddress_id,
                nucomp_prod_prov_id,
                nucategory_id,
                nusubcategory_id);

   INSERT INTO pr_component_link
        VALUES (
                  nucomponent_link_id,
                  nuparent_component_id,
                  nuchild_component_id);



EXCEPTION
   WHEN ex.controlled_error
   THEN
      errors.geterror(onuerrorcode,osberrormessage) ;

   WHEN OTHERS
   THEN
      errors.seterror;
      errors.geterror(onuerrorcode,osberrormessage) ;
      osberrormessage:=SQLERRM;
END; 
/
