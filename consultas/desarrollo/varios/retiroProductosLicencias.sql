DECLARE
    nuErrorCode NUMBER;
    sbErrorMessage VARCHAR2(4000);
    nuComponenId    pr_component.component_id%type;
    nuRetireType    ge_retire_type.retire_type_id%type;
    dtFechaRetiro   date;
    CURSOR cuProdRetirar
    IS
        select b.*, b.rowid
        from  pr_product b, servicio, servsusc
        where B.PRODUCT_TYPE_ID in (7053, 7055, 7056, 7052, 7054)
        and   B.PRODUCT_TYPE_ID = servcodi
        and   sesunuse = product_id
        and   b.product_status_id = 1
        and   sesuesco not in (96,95,6,94,110,111)
        and   not exists (select /*INDEX (DIFERIDO IX_DIFE_NUSE) */ 'x' from diferido where difenuse=B.PRODUCT_ID )
        and   not exists (select  'x' from cuencobr where cuconuse=B.PRODUCT_ID AND cucocodi>-1);
        
    PROCEDURE InsProductRetire
        (
        inuProductId    in Pr_Product_Retire.Product_Id%type,
        inuRetireTypeId in Pr_Product_Retire.Retire_Type_Id%type,
        idtRetireDate   in Pr_Product_Retire.Retire_Date%type,
        idtRegisterDate in Pr_Product_Retire.Register_Date%type
        )
    IS
        rcProductRetire DAPR_Product_Retire.styPR_Product_Retire;
    BEGIN

        rcProductRetire.Product_Retire_Id := PR_BOSequence.GetProductRetireId;
        rcProductRetire.Product_Id := inuProductId;
        rcProductRetire.Retire_Type_Id := inuRetireTypeId;
        rcProductRetire.Retire_Date := idtRetireDate;
        rcProductRetire.Register_Date := idtRegisterDate;
        DAPR_Product_Retire.insRecord(rcProductRetire);

        UT_Trace.Trace('Registro Insertado en Pr_Product_Retire:['||rcProductRetire.Product_Retire_Id||']',15);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;
    
    PROCEDURE InsComponentRetire
        (
        inuComponentId  in Pr_Component_Retire.Component_Id%type,
        inuRetireTypeId in Pr_Component_Retire.Retire_Type_Id%type,
        idtRetireDate   in Pr_Component_Retire.Retire_Date%type,
        idtRegisterDate in Pr_Component_Retire.Register_Date%type,
        isbIndivRetire      in Pr_Component_Retire.Individual_Retire%type default 'Y'
        )
    IS
        rcComponentRetire   DAPR_Component_Retire.styPR_Component_Retire;
        rcCompsesu          compsesu%rowtype;
        dtRetireDate        Pr_Component_Retire.Retire_Date%type := idtRetireDate;
    BEGIN

        rcComponentRetire.Component_Retire_Id := PR_BOSequence.GetComponentRetireId;
        rcComponentRetire.Component_Id := inuComponentId;
        rcComponentRetire.Retire_Type_Id := inuRetireTypeId;
        rcComponentRetire.Retire_Date := dtRetireDate;
        rcComponentRetire.Register_Date := idtRegisterDate;
        rcComponentRetire.individual_retire := isbIndivRetire;
        DAPR_Component_Retire.insRecord(rcComponentRetire);

        UT_Trace.Trace('Registro Insertado en Pr_Component_Retire:['||rcComponentRetire.Component_Retire_Id||']',15);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;
BEGIN                         -- ge_module
    errors.Initialize;
    ut_trace.Init;
    ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
    ut_trace.SetLevel(0);
    ut_trace.Trace('INICIO');
    -- se deshabilita el trigger de actualizacion de cupo
    execute immediate 'alter trigger trgauAllocateQuoteEsFn disable';
    -- se retira con el tipo de retiro administrativa
    nuRetireType:=2;
    dtFechaRetiro:= ut_date.fdtsysdate;
    -- se realiza el retiro del producto
    for rcProduct in cuProdRetirar loop
        -- se retira el producto en OSS
        rcProduct.product_status_id:= pr_boparameter.fnuGetProdReti;
        rcProduct.retire_date:=dtFechaRetiro;
        dapr_product.updrecord(rcProduct);
        
        for rcComponent in pr_bcproduct.cuComponentsProduct(rcProduct.product_id) loop
            rcComponent.Component_Status_Id := PR_BOParameter.fnuGetCompReti;
            rcComponent.Last_Upd_Date := dtFechaRetiro;
            DAPR_Component.updRecord(rcComponent);
            -- inserta información de retiro del componente
            InsComponentRetire(rcComponent.Component_Id,nuRetireType,dtFechaRetiro,dtFechaRetiro,ge_boconstants.getYes);
            -- actualiza el componente en BSS
            UPDATE compsesu
            SET  cmssfere = dtFechaRetiro,
    	    cmssescm = PR_BOParameter.fnuGetCompReti
            WHERE cmssidco=rcComponent.Component_Id;

        END loop;
        -- actualiza el estado del producto en BSS
        pktblServsusc.UpSuspensionStatus( rcProduct.product_id,
                                         94, --pkGeneralParametersMgr.fnuGetNumberValue('INICIORETIRO_ATENCLIE'),
                                         dtFechaRetiro );
        -- Actualiza la fecha de Retiro del Servicio Suscrito
        pktblServsusc.UpWithDrawDate
        (
            rcProduct.product_id,
            dtFechaRetiro
        );

        -- se inserta información de retiro del producto
        InsProductRetire(rcProduct.product_id,nuRetireType,dtFechaRetiro,dtFechaRetiro);
        -- se actualiza el estado del cliente
        GE_BOSubscriber.SetSubscriberStatus(pktblsuscripc.fnuGetCustomer(rcProduct.subscription_id, pkConstante.NOCACHE));
        
        commit;
    END loop;

    -- se deshabilita el trigger de actualizacion de cupo
    execute immediate 'alter trigger trgauAllocateQuoteEsFn enable';
END;
/
