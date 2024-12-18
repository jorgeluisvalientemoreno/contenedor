DECLARE
    -- Datos de Entrada
    NUORDERID_1     OR_ORDER.ORDER_ID%TYPE;
    
    -- Datos de salida
    NUPACKAGEID     MO_PACKAGES.PACKAGE_ID%TYPE;
    NUID            FM_POSSIBLE_NTL.POSSIBLE_NTL_ID%TYPE;
    NUORDERID       OR_ORDER.ORDER_ID%TYPE;
    NUORDERID_ACT   OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE;
    
    Cursor cuOrdenesRegistradas
    IS
    select  /*+ LEADING(oo oa) */
            oo.ORDER_ID,
            oo.ORDER_STATUS_ID as Estado_orden_lab,
            oo.task_type_id as TT_OT_laboratorio,
            -- datos de la orden padre
            oo1.ORDER_ID as ot_pad,
            oo1.ORDER_STATUS_ID as Estado_orden_pad,
            oo1.task_type_id as TT_OT_pad,
            oa.PRODUCT_ID, --> Producto con posible pérdida no técnica
            se.sesususc as contrato,
            oa.SUBSCRIBER_ID as SUBSCRIBER_ID,
            ad.GEOGRAP_LOCATION_ID,--> Ubicación geográfica
            oa.ADDRESS_ID, --> Dirección de posible pérdida no técnica
            se.SESUSERV as PRODUCT_TYPE_ID, --> Tipo de producto de posible pérdida no técnica
            oa.comment_ as COMMENT_, --> Comentario
            5 as DISCOVERY_TYPE_ID, --> Tipo de descubrimiento
            0 as VALUE_, --> Valor de posible pérdida
            NULL as INFORMER_SUBS_ID, --> Subscriptor Informante
            'R' as STATUS, --> R - Proyecto
            oa.ACTIVITY_ID as ITEMS_ID,
            NULL as PERSON_ID,
            -- datos para la creacion de la orden 
            oo.OPERATING_SECTOR_ID as OPERATING_SECTOR_ID
    from    open.or_order oo
            inner join open.or_order_activity oa on oo.ORDER_ID = oa.ORDER_ID
            inner join open.servsusc se on se.sesunuse = oa.PRODUCT_ID
            inner join open.ab_address ad on oa.address_id = ad.address_id
            inner join open.or_related_order r1 on (oo.ORDER_ID = r1.RELATED_ORDER_ID)
            inner join open.or_order oo1 on (r1.ORDER_ID = oo1.ORDER_ID)
    where   oo1.task_type_id  = 12669
    and     r1.rela_order_type_id IN (2,   --> Regeneración
									  13 --> Orden Relacionada
									  )
    and     oo.order_id in (282876802);

    PROCEDURE REGISTER_FMCAP
    (
        INUPRODUCT              IN      FM_POSSIBLE_NTL.PRODUCT_ID%TYPE,
        INUGEOGRALOCATION       IN      FM_POSSIBLE_NTL.GEOGRAP_LOCATION_ID%TYPE,
        INUADDRESSID            IN      FM_POSSIBLE_NTL.ADDRESS_ID%TYPE,
        INUPRODUCTTYPE          IN      FM_POSSIBLE_NTL.PRODUCT_TYPE_ID%TYPE,
        ISBCOMMENT              IN      FM_POSSIBLE_NTL.COMMENT_%TYPE,
        INUDISCOVERYTYPE        IN      FM_POSSIBLE_NTL.DISCOVERY_TYPE_ID%TYPE,
        INUVALUE                IN      FM_POSSIBLE_NTL.VALUE_%TYPE,
        ISBINFORMER             IN      FM_POSSIBLE_NTL.INFORMER_SUBS_ID%TYPE,
        ISBSTATUS               IN      FM_POSSIBLE_NTL.STATUS%TYPE,
        INUACTIVITYID           IN      GE_ITEMS.ITEMS_ID%TYPE,
        INUPERSONID             IN      FM_POSSIBLE_NTL.PERSON_ID%TYPE,
        INUORDERID_1            IN      OR_ORDER.ORDER_ID%TYPE,
        ONUID                   OUT     FM_POSSIBLE_NTL.POSSIBLE_NTL_ID%TYPE,
        ONUORDERID              OUT     OR_ORDER.ORDER_ID%TYPE,
        ONUPACKAGEID            OUT     MO_PACKAGES.PACKAGE_ID%TYPE
    )
    IS
        RCPOSSIBLENTL       DAFM_POSSIBLE_NTL.STYFM_POSSIBLE_NTL;
        
        NUPRODUCTTYPE       FM_POSSIBLE_NTL.PRODUCT_TYPE_ID%TYPE;
        NUADDRESS           FM_POSSIBLE_NTL.ADDRESS_ID%TYPE;
        NUGEOGRAPHLOCATION  FM_POSSIBLE_NTL.GEOGRAP_LOCATION_ID%TYPE;
        
        CSBNTL_ENTITYNAME   CONSTANT    GE_ENTITY.NAME_%TYPE        := 'FM_POSSIBLE_NTL';
        CSBNTL_SEQNAME      CONSTANT    VARCHAR2(2000)              := 'SEQ_FM_POSSIBLE_NTL_123873';
        CNURECORDEXISTS     CONSTANT    GE_MESSAGE.MESSAGE_ID%TYPE  := 900255;

    BEGIN
    
        NUPRODUCTTYPE       := INUPRODUCTTYPE;
        NUADDRESS           := INUADDRESSID;
        NUGEOGRAPHLOCATION  := INUGEOGRALOCATION;

        IF INUPRODUCT IS NOT NULL THEN

            ONUID := FM_BCREGISTER.FNUPENDNTLBYPROD(INUPRODUCT);
            NUPRODUCTTYPE   := DAPR_PRODUCT.FNUGETPRODUCT_TYPE_ID(INUPRODUCT);
            NUADDRESS       := DAPR_PRODUCT.FNUGETADDRESS_ID(INUPRODUCT);

        END IF;
        
        IF NUADDRESS IS NOT NULL AND NUADDRESS <> -1 AND NUPRODUCTTYPE IS NOT NULL THEN
            ONUID := FM_BCREGISTER.FNUPENDNTLBYADDR(NUADDRESS, NUPRODUCTTYPE);
        END IF;
        
        IF NUADDRESS IS NOT NULL AND NUADDRESS <> -1 THEN
            NUGEOGRAPHLOCATION := DAAB_ADDRESS.FNUGETGEOGRAP_LOCATION_ID(NUADDRESS);
        END IF;

        IF NUGEOGRAPHLOCATION IS NOT NULL
            AND NUPRODUCTTYPE IS NOT NULL
            AND (NUADDRESS IS NULL OR INUADDRESSID = -1) THEN
            ONUID := FM_BCREGISTER.FNUPENDNTLBYGEOLOC(NUGEOGRAPHLOCATION, NUPRODUCTTYPE);
            IF ONUID IS NOT NULL THEN
                NULL;
            END IF;
        END IF;

        RCPOSSIBLENTL.POSSIBLE_NTL_ID       :=  GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE(CSBNTL_ENTITYNAME, CSBNTL_SEQNAME);
        RCPOSSIBLENTL.STATUS                :=  ISBSTATUS;
        RCPOSSIBLENTL.PRODUCT_ID            :=  INUPRODUCT;
        RCPOSSIBLENTL.PRODUCT_TYPE_ID       :=	NUPRODUCTTYPE;
        RCPOSSIBLENTL.GEOGRAP_LOCATION_ID   :=	NUGEOGRAPHLOCATION;
        RCPOSSIBLENTL.ADDRESS_ID            :=	NUADDRESS;
        RCPOSSIBLENTL.REGISTER_DATE         :=	UT_DATE.FDTSYSDATE;
        RCPOSSIBLENTL.DISCOVERY_TYPE_ID     :=	INUDISCOVERYTYPE;
        RCPOSSIBLENTL.INFORMER_SUBS_ID      :=	ISBINFORMER;
        RCPOSSIBLENTL.COMMENT_              :=  ISBCOMMENT;
        RCPOSSIBLENTL.VALUE_                :=	INUVALUE;
        RCPOSSIBLENTL.PERSON_ID             :=  INUPERSONID;

        RCPOSSIBLENTL.ORDER_ID  := INUORDERID_1;

        DAFM_POSSIBLE_NTL.INSRECORD(RCPOSSIBLENTL);
        
        ONUID := RCPOSSIBLENTL.POSSIBLE_NTL_ID;
        
        commit;

    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(' Error al crear el proyecto para la orden ['||INUORDERID_1||'] Error = '||sqlerrm);
    END REGISTER_FMCAP;


BEGIN
    DBMS_OUTPUT.PUT_LINE('------------- Inicio Registro en FM_POSSIBLE_NTL  -------------');
    
    FOR reg IN cuOrdenesRegistradas
    LOOP
        BEGIN
          REGISTER_FMCAP
          (
              INUPRODUCT              => reg.PRODUCT_ID,
              INUGEOGRALOCATION       => reg.GEOGRAP_LOCATION_ID,
              INUADDRESSID            => reg.ADDRESS_ID,
              INUPRODUCTTYPE          => reg.PRODUCT_TYPE_ID,
              ISBCOMMENT              => reg.COMMENT_,
              INUDISCOVERYTYPE        => reg.DISCOVERY_TYPE_ID,
              INUVALUE                => reg.VALUE_,
              ISBINFORMER             => reg.INFORMER_SUBS_ID,
              ISBSTATUS               => reg.STATUS,
              INUACTIVITYID           => reg.ITEMS_ID,
              INUPERSONID             => reg.PERSON_ID,
              INUORDERID_1            => reg.ot_pad,
              ONUID                   => NUID,
              ONUORDERID              => NUORDERID,
              ONUPACKAGEID            => NUPACKAGEID
          );

          DBMS_OUTPUT.PUT_LINE('Se crea el Proyecto FMCAP ['||NUID||']'
                              ||' - Orden Laboratorio ['||reg.ORDER_ID||']'
                              ||' - Orden Padre ['||reg.ot_pad||']'
                              ||' - Producto ['||reg.PRODUCT_ID||']'
                              ||' - Contrato ['||reg.contrato||']'
                            );
          COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
              rollback;
              DBMS_OUTPUT.PUT_LINE('Error REGISTER_FMCAP: '||sqlerrm);
        END;
        
    end loop;
    DBMS_OUTPUT.PUT_LINE('------------- FIN Registro en FM_POSSIBLE_NTL -------------');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error General Registro en FM_POSSIBLE_NTL '||sqlerrm);
END;
/