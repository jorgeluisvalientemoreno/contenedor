CREATE OR REPLACE PACKAGE      adm_person.ldc_pkg_changstatesolici
AS
/*****************************************************************
Propiedad intelectual de Gases de occidente.

Nombre del Paquete: ldc_pkg_changstatesolici
Descripcion: Se realiza la transicion de estados de la solicitud y el producto

Autor  : Sergio Gomez
Fecha  : 22-07-2015

Historia de Modificaciones

DD-MM-YYYY    <Autor>.        Modificacion
-----------  -------------------    -------------------------------------
19/06/2024     PAcosta                OSF-2845: Cambio de esquema ADM_PERSON 
22-07-2015     SAGOMEZ                Creacion del paquete
******************************************************************/
   PROCEDURE packageinttransition (
      inupackageid       IN   mo_packages.package_id%TYPE,
      inuannulcausalid   IN   mo_motive.annul_causal_id%TYPE
   );
END ldc_pkg_changstatesolici;
/
CREATE OR REPLACE PACKAGE BODY      adm_person.ldc_pkg_changstatesolici
AS
/*****************************************************************
Propiedad intelectual de Gases de occidente.

Nombre del Paquete: ldc_pkg_changstatesolici
Descripcion: Se realiza la transicion de estados de la solicitud y el producto

Autor  : Sergio Gomez
Fecha  : 22-07-2015

Historia de Modificaciones

DD-MM-YYYY    <Autor>.        Modificacion
-----------  -------------------    -------------------------------------
22-07-2015     SAGOMEZ                Creacion del paquete
******************************************************************/


    CSBMOTIVE_INSTANCE  CONSTANT VARCHAR2(250) := MO_BOUNCOMPOSITIONCONSTANTS.CSBMOTIVE_INSTANCE;

        CURSOR CUPACKAGESNOTANNUL
    (
        INUREQUESTID    IN      MO_PACKAGES.PACKAGE_ID%TYPE
    )
    IS
        SELECT A.PACKAGE_ID
          FROM MO_PACKAGES A, MO_PACKAGES_ASSO B
         WHERE A.PACKAGE_ID = B.PACKAGE_ID
           AND PACKAGE_ID_ASSO = INUREQUESTID
           AND A.MOTIVE_STATUS_ID NOT IN
               (
                   MO_BOSTATUSPARAMETER.FNUGETSTATUS_ANNUL_PACK,
                   MO_BOCONSTANTS.CNUSTATUS_IN_ANNUL_PACK
               );

     FUNCTION FBLALLPACKISANULLINREQ
    (
        INUPACKAGEID        IN          MO_PACKAGES.PACKAGE_ID%TYPE
    )
    RETURN BOOLEAN
    IS

        BLRESULT        BOOLEAN;
        NUPACKAGEID     MO_PACKAGES.PACKAGE_ID%TYPE;

    BEGIN

        IF (INUPACKAGEID IS NULL) THEN
            RETURN GE_BOCONSTANTS.GETFALSE;
        END IF;

        OPEN   CUPACKAGESNOTANNUL ( INUPACKAGEID );
        FETCH  CUPACKAGESNOTANNUL INTO NUPACKAGEID;
        BLRESULT := CUPACKAGESNOTANNUL%NOTFOUND;
        CLOSE   CUPACKAGESNOTANNUL;

        RETURN ( BLRESULT );
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            IF (CUPACKAGESNOTANNUL%ISOPEN) THEN
                CLOSE CUPACKAGESNOTANNUL;
            END IF;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            IF (CUPACKAGESNOTANNUL%ISOPEN) THEN
                CLOSE CUPACKAGESNOTANNUL;
            END IF;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END;


   PROCEDURE validwithdrawcompbeforeinst (
      inucomponentid   IN   mo_component.component_id%TYPE
   )
   IS
      rcmocomponent   damo_component.stymo_component;
      rcprcomponent   dapr_component.stypr_component;
   BEGIN
      rcmocomponent := damo_component.frcgetrecord (inucomponentid);
      ut_trace.TRACE
         (   'INICIO ldc_pkg_changstatesolici.ValidWithdrawCompBeforeInst MOComp:['
          || rcmocomponent.component_id
          || '] TY:['
          || rcmocomponent.motive_type_id
          || '] PR:['
          || rcmocomponent.component_id_prod
          || ']',
          20
         );

      IF (rcmocomponent.component_id_prod IS NULL)
      THEN
         ut_trace.TRACE
            ('FIN ldc_pkg_changstatesolici.ValidWithdrawCompBeforeInst - No tiene componente de producto',
             20
            );
         RETURN;
      END IF;

      IF (rcmocomponent.motive_type_id IN
             (mo_boconstants.cnuinstal_moti_type,
              mo_boconstants.cnuservadd_motive_type,
              ps_bomotivetype.fnubundcomp_moti_type
             )
         )
      THEN
         rcprcomponent :=
                dapr_component.frcgetrecord (rcmocomponent.component_id_prod);

         IF (daps_product_status.fsbgetis_final_status
                                            (rcprcomponent.component_status_id) =
                                                          cc_boconstants.csbno
            )
         THEN
            ut_trace.TRACE
                (   'Retira sin instalaci?n el componente, Estado anterior['
                 || rcprcomponent.component_status_id
                 || ']',
                 21
                );
            pr_boretire.withdrawcompbeforeinst
                                      (rcprcomponent,
                                       pr_boconstants.cnurettypadministrative,
                                       SYSDATE
                                      );
         END IF;
      END IF;

      ut_trace.TRACE
                   ('FIN ldc_pkg_changstatesolici.ValidWithdrawCompBeforeInst - Ok',
                    20
                   );
   EXCEPTION
      WHEN ex.controlled_error
      THEN
         RAISE ex.controlled_error;
      WHEN OTHERS
      THEN
         ERRORS.seterror;
         RAISE ex.controlled_error;
   END validwithdrawcompbeforeinst;

   PROCEDURE updateobject (
      inuexternalid      IN   NUMBER,
      isbentityname      IN   VARCHAR2,
      inuannulcausalid   IN   NUMBER,
      inuactionid        IN   NUMBER,
      iblnotify          IN   BOOLEAN,
      iblupdatecausa     IN   BOOLEAN
   )
   IS
      nurelationstatus   ps_motive_action.moti_status_relation%TYPE;
   BEGIN
      ut_trace.TRACE ('Inicia Metodo ldc_pkg_changstatesolici.UpdateObject', 8);
      ut_trace.TRACE (   'Entidad:['
                      || isbentityname
                      || ']Identificador:['
                      || inuexternalid
                      || ']',
                      9
                     );
      ge_boinstancecontrol.loadentityoldvaluesid (csbmotive_instance,
                                                  NULL,
                                                  isbentityname,
                                                  TO_CHAR (inuexternalid)
                                                 );

      IF (iblupdatecausa)
      THEN
         ge_boinstancecontrol.setattributenewvalue
                                          (csbmotive_instance,
                                           NULL,
                                           isbentityname,
                                           mo_boconstants.csbannul_causal_id,
                                           TO_CHAR (inuannulcausalid)
                                          );
      END IF;

      IF (isbentityname = mo_boconstants.csbmo_motive)
      THEN
         mo_boactioncontroller.motivestatus (inuactionid, nurelationstatus);
      ELSIF (isbentityname = mo_boconstants.csbmo_component)
      THEN
         mo_boactioncontroller.componentstatus (inuactionid,
                                                nurelationstatus);
      ELSIF (isbentityname = mo_boconstants.csbmo_packages)
      THEN
         mo_boactioncontroller.packagestatus (inuactionid, nurelationstatus);
      END IF;

      ge_boinstancecontrol.updateentity (csbmotive_instance,
                                         NULL,
                                         isbentityname
                                        );
      ge_boinstancecontrol.clearentity (csbmotive_instance,
                                        NULL,
                                        isbentityname
                                       );
      ut_trace.TRACE ('Finaliza Metodo ldc_pkg_changstatesolici.UpdateObject', 8);
   EXCEPTION
      WHEN ex.controlled_error
      THEN
         RAISE ex.controlled_error;
      WHEN OTHERS
      THEN
         ERRORS.seterror;
         RAISE ex.controlled_error;
   END;

   PROCEDURE annulcomponents (
      inumotiveid        IN   mo_motive.motive_id%TYPE,
      inuannulcausalid   IN   mo_motive.annul_causal_id%TYPE,
      inuactionid        IN   ge_action_module.action_id%TYPE
   )
   IS
      curfcomponentsbymotive   constants.tyrefcursor;
      rccomponentsbymotive     mo_bccomponent.styrccomponentsbymotive;
   BEGIN
      ut_trace.TRACE ('Inicia Metodo ldc_pkg_changstatesolici.AnnulComponents', 4);
      curfcomponentsbymotive :=
                           mo_bccomponent.frfcomponentsbymotive (inumotiveid);

      FETCH curfcomponentsbymotive
       INTO rccomponentsbymotive;

      WHILE curfcomponentsbymotive%FOUND
      LOOP
         ut_trace.TRACE (   'Componente:['
                         || rccomponentsbymotive.component_id
                         || ']Estado:['
                         || rccomponentsbymotive.motive_status_id
                         || ']',
                         5
                        );

         IF mo_bomotiveactionutil.fblcurrstatisvalidgencomp
                                     (inuactionid,
                                      rccomponentsbymotive.motive_status_id,
                                      rccomponentsbymotive.prod_motive_comp_id
                                     )
         THEN
            updateobject (rccomponentsbymotive.component_id,
                          mo_boconstants.csbmo_component,
                          inuannulcausalid,
                          inuactionid,
                          FALSE,
                          TRUE
                         );
            validwithdrawcompbeforeinst (rccomponentsbymotive.component_id);
         END IF;

         FETCH curfcomponentsbymotive
          INTO rccomponentsbymotive;
      END LOOP;

      CLOSE curfcomponentsbymotive;

      ut_trace.TRACE ('Finaliza Metodo ldc_pkg_changstatesolici.AnnulComponents', 4);
   EXCEPTION
      WHEN ex.controlled_error
      THEN
         ge_bogeneralutil.close_refcursor (curfcomponentsbymotive);
         RAISE ex.controlled_error;
      WHEN OTHERS
      THEN
         ge_bogeneralutil.close_refcursor (curfcomponentsbymotive);
         ERRORS.seterror;
         RAISE ex.controlled_error;
   END;

   PROCEDURE lockedpackage (
      inupackageid   IN       mo_packages.package_id%TYPE,
      orcpackage     OUT      damo_packages.stymo_packages
   )
   IS
      nupackageid   mo_packages.package_id%TYPE;
   BEGIN
      orcpackage := damo_packages.frcgetrecord (inupackageid);

      SELECT a.package_id
        INTO nupackageid
        FROM mo_packages a
       WHERE a.package_id = inupackageid;

      ut_trace.TRACE ('Bloquea FOR UPDATE el Paquete:[' || inupackageid || ']',
                      4
                     );
   EXCEPTION
      WHEN ex.controlled_error
      THEN
         RAISE ex.controlled_error;
      WHEN OTHERS
      THEN
         ERRORS.seterror;
         RAISE ex.controlled_error;
   END lockedpackage;

   PROCEDURE packageinttransition (
      inupackageid       IN   mo_packages.package_id%TYPE,
      inuannulcausalid   IN   mo_motive.annul_causal_id%TYPE
   )
   IS
      rcpackages    damo_packages.stymo_packages;
      tbmotives     damo_motive.tytbmo_motive;
      nuindx        BINARY_INTEGER;
      tbassopacks   damo_packages_asso.tytbmo_packages_asso;
      nufatheridx   BINARY_INTEGER;
   BEGIN
      ut_trace.TRACE ('INICIO ldc_pkg_changstatesolici.PackageIntTransition', 5);
      ge_boinstancecontrol.initinstancemanager;
      ge_boinstancecontrol.createinstance (csbmotive_instance, NULL);
      ut_trace.TRACE ('INICIO ldc_pkg_changstatesolici.PackageIntTransition1', 5);
      lockedpackage (inupackageid, rcpackages);
      mo_bomotiveactionutil.validateactionforpack
                            (inupackageid,
                             rcpackages.motive_status_id,
                             mo_boactionparameter.fnugetaction_annul_interna,
                             rcpackages.package_type_id
                            );
      ut_trace.TRACE ('INICIO ldc_pkg_changstatesolici.PackageIntTransition2', 5);
      tbmotives := mo_bcmotive.ftballmotivesbypack (inupackageid);
      nuindx := tbmotives.FIRST;

      WHILE (nuindx IS NOT NULL)
      LOOP
         ut_trace.TRACE (   'Anula Motivo:['
                         || tbmotives (nuindx).motive_id
                         || ']Estado:['
                         || tbmotives (nuindx).motive_status_id
                         || ']',
                         6
                        );

         IF (mo_bomotiveactionutil.fblcurrstatisvalidgenmot
                             (mo_boactionparameter.fnugetaction_annul_interna,
                              tbmotives (nuindx).motive_status_id,
                              tbmotives (nuindx).product_motive_id
                             )
            )
         THEN
            annulcomponents (tbmotives (nuindx).motive_id,
                             inuannulcausalid,
                             mo_boactionparameter.fnugetaction_annul_interna
                            );
            ut_trace.TRACE ('Inici? Transici?n de Estados Para el Motivo', 6);
            updateobject (tbmotives (nuindx).motive_id,
                          mo_boconstants.csbmo_motive,
                          inuannulcausalid,
                          mo_boactionparameter.fnugetaction_annul_interna,
                          TRUE,
                          TRUE
                         );

            IF (tbmotives (nuindx).motive_type_id =
                                            mo_boconstants.cnuinstal_moti_type
               )
            THEN
               ut_trace.TRACE
                  ('Inici? la actualizaci?n del estado del producto a Retirado sin instalaci?n.',
                   6
                  );
               pr_boproduct.updprodretuninstall (tbmotives (nuindx).package_id,
                                                 tbmotives (nuindx).motive_id
                                                );
            END IF;

            IF (tbmotives (nuindx).motive_type_id IN
                   (mo_boconstants.cnuretire_moti_type,
                    mo_boconstants.cnumove_moti_type
                   )
               )
            THEN
               ut_trace.TRACE
                  ('Inici? la actualizaci?n del estado del producto a Activo ? Suspendido.',
                   6
                  );
               pr_boproduct.updprodpendretorpendtras
                                                (tbmotives (nuindx).package_id,
                                                 tbmotives (nuindx).motive_id
                                                );
            END IF;

            IF (tbmotives (nuindx).motive_type_id =
                                          ps_bomotivetype.fnubundled_moti_type
               )
            THEN
               cc_bobundlingprocess.retirebundledbyprod
                                                (tbmotives (nuindx).product_id
                                                );
            END IF;
         END IF;

         nuindx := tbmotives.NEXT (nuindx);
      END LOOP;

      ut_trace.TRACE (   'Inici? La Transici?n de Estados del Paquete:['
                      || inupackageid
                      || ']',
                      6
                     );
      mo_boactioncontroller.packageinternaltransition
                              (inupackageid,
                               mo_boactionparameter.fnugetaction_annul_interna
                              );
      ge_boinstancecontrol.stopinstancemanager;
      tbassopacks := mo_bcpackages_asso.ftbpackassobypackid (inupackageid);
      nufatheridx := tbassopacks.FIRST;

      WHILE (nufatheridx IS NOT NULL)
      LOOP
         IF (    tbassopacks (nufatheridx).annul_dependent =
                                                          cc_boconstants.csbsi
             AND fblallpackisanullinreq
                                     (tbassopacks (nufatheridx).package_id_asso
                                     )
            )
         THEN
            ut_trace.TRACE (   'Anula la sol Padre, Id['
                            || tbassopacks (nufatheridx).package_id_asso
                            || ']',
                            6
                           );
            packageinttransition (tbassopacks (nufatheridx).package_id_asso,
                                  inuannulcausalid
                                 );
         END IF;

         nufatheridx := tbassopacks.NEXT (nufatheridx);
      END LOOP;

      ut_trace.TRACE ('FIN ldc_pkg_changstatesolici.PackageIntTransition - OK', 5);
   EXCEPTION
      WHEN ex.controlled_error
      THEN
         ge_boinstancecontrol.stopinstancemanager;
         RAISE ex.controlled_error;
      WHEN OTHERS
      THEN
         ge_boinstancecontrol.stopinstancemanager;
         ERRORS.seterror;
         RAISE ex.controlled_error;
   END packageinttransition;

END ldc_pkg_changstatesolici;
/
PROMPT Otorgando permisos de ejecucion a LDC_PKG_CHANGSTATESOLICI
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PKG_CHANGSTATESOLICI', 'ADM_PERSON');
END;
/