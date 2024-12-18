CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_ANULASOLICITUD
    (
        inuPackageId    IN Mo_Packages.Package_Id%TYPE
    )
	IS
        rcPackages          DAMO_Packages.styMO_Packages;
        curfMotive          Constants.tyRefCursor;
        curfComponent       Constants.tyRefCursor;
        rcMotive            DAMO_Motive.styMO_Motive;
        rcComponent         DAMO_Component.styMO_Component;
        nuStatusId          mo_packages.motive_status_id%TYPE;
        tbAssoPacks         damo_packages_asso.tytbMO_packages_asso;
        nuFatherIdx         binary_integer;
        csbMOTIVE_INSTANCE  CONSTANT VARCHAR2(250) := MO_BOUnCompositionConstants.csbMOTIVE_INSTANCE;
	BEGIN
        UT_Trace.Trace('Inicia Metodo AnulaSolicitud. Paquete:['||inuPackageId||']',1);

            -- Inicializa instancia
            GE_BOInstanceControl.InitInstanceManager;

            -- Creamos la Instancia
            GE_BOInstanceControl.CreateInstance(csbMOTIVE_INSTANCE,NULL);

        -- Se obtiene el estado actual del paquete
        nuStatusId := DAMO_Packages.fnuGetMotive_Status_Id(inuPackageId);

        -- Se verifica si el paquete no ha sido anulado previamente
        IF (nuStatusId <> MO_BOConstants.cnuSTATUS_ANNUL_PACK) THEN


            -- Obtiene los motivos del paquete
            curfMotive := MO_BCMotive.frfMotivesByPackageId(inuPackageId);
            FETCH curfMotive INTO rcMotive;
            WHILE curfMotive%FOUND LOOP
                UT_Trace.Trace('Anula Motivo:['||rcMotive.Motive_Id||']Estado:['||rcMotive.Motive_Status_Id||']',2);



                    -- Obtiene los componentes asociados al motivo
                    curfComponent := MO_BCComponent.frfComponentsByMotive(rcMotive.Motive_Id);
                    FETCH curfComponent INTO rcComponent;
                    WHILE curfComponent%FOUND LOOP
                        UT_Trace.Trace('Anula Componente:['||rcComponent.Component_Id||']Estado:['||rcComponent.Motive_Status_Id ||']',3);



                            UT_Trace.Trace('Inició La Transición de Estados del Componente:['||rcComponent.Component_Id||']',3);
                             -- Ejecuta transición de estados para el componente
                            MO_BOActionController.ComponentInternalTransition(rcComponent.Component_Id,MO_BOActionParameter.fnugetaction_annul_interna);


                        FETCH curfComponent INTO rcComponent;
                    END LOOP;
                    CLOSE curfComponent;

                    UT_Trace.Trace('Inició La Transición de Estados del Motivo:['||rcMotive.Motive_Id||']',2);
                    -- Ejecuta transición de estados para el motivo
                    MO_BOActionController.MotiveInternalTransition(rcMotive.Motive_Id,MO_BOActionParameter.fnugetaction_annul_interna);


                FETCH curfMotive INTO rcMotive;
            END LOOP;
            CLOSE curfMotive;

        --}
        END IF;

        -- Ejecuta transición de estados para el paquete
        MO_BOActionController.PackageInternalTransition(inuPackageId,MO_BOActionParameter.fnugetaction_annul_interna);

        UT_Trace.Trace('Finaliza Metodo AnulaSolicitud',1);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            GE_BOInstanceControl.StopInstanceManager;
            GE_BOGeneralUtil.Close_RefCursor(curfMotive);
            GE_BOGeneralUtil.Close_RefCursor(curfComponent);
            RAISE ex.CONTROLLED_ERROR;
        WHEN others THEN
            GE_BOInstanceControl.StopInstanceManager;
            GE_BOGeneralUtil.Close_RefCursor(curfMotive);
            GE_BOGeneralUtil.Close_RefCursor(curfComponent);
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
END LDC_ANULASOLICITUD;
/
PROMPT Otorgando permisos de ejecucion a LDC_ANULASOLICITUD
BEGIN
  pkg_utilidades.prAplicarPermisos('LDC_ANULASOLICITUD','ADM_PERSON');
END;
/
