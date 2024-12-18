column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;


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
            'Proyecto Creado por el Caso OSF-1183' as COMMENT_, --> Comentario
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
    and     r1.rela_order_type_id IN ( 
                                    2   --> Regeneración
                                    ,13 --> Orden Relacionada
                                  )
    and     oo.order_id in ( 
                            272593580, 260339021, 262201676, 260649664, 266399070, 251050049, 239561278, 231650437, 233833197, 262201500, 246072736, 238379194,
                            238637052, 193628225, 230473714, 227699868, 262604480, 262604519, 262604459, 262604445, 262604568, 235986639, 239015725, 255642886,
                            246163998, 265950506, 253978541, 210749769, 239938400, 244382531, 258405910, 258405579, 266399407, 265637361, 229214815, 237431043,
                            250908835, 237445829, 260340587, 238907267, 262604371, 249695147, 255425673, 237518615, 237518763, 242923487, 241389030, 250908445,
                            250909332, 258970349, 239939791, 237804864, 238609241, 239068578, 239680518, 229214166, 237445457, 254609884, 246081098, 232390099,
                            258963991, 263469281, 237513217, 234460204, 236351014, 227698699, 256400002, 251369816, 235603235, 234706454, 235978567, 238609421,
                            227694293, 272854585, 225512780, 232274095, 236775323, 229745384, 238992539, 227699451, 236093420, 265953462, 236901194, 263265841,
                            256721820, 273348952, 233626907, 229359998, 236668563, 236668213, 262604307, 266564107, 239847624, 238305738, 230803251, 273239875,
                            238061177, 229726454, 238305271, 250262768, 239134711, 238862600, 231649110, 239683038, 269392745, 238669411, 232081810, 243435513,
                            228090401, 228606742, 230473797, 255373300, 267067759, 275109540, 232556341, 233834054, 230803554, 230462694, 238305342, 241411583,
                            239683044, 257812961, 228180855, 257317488, 249697335, 229726997, 263793731, 244693602, 231649547, 238355773, 231649876, 239848057,
                            261077133, 243304005, 257317581, 250545169, 254120305, 246163902, 241918709, 255642890, 267275981, 255586774, 247567907, 245487514,
                            255642877, 255643238, 255989212, 260340437, 258273152, 276477616, 256842011, 256841836, 265637306, 260341503, 256161529, 260339203,
                            272720290, 239941085, 239940064, 238369061, 260788306, 263266707, 245242424, 233132565, 233498685, 238609497, 247112833, 247112973,
                            246164032, 266399844, 280157787, 258403525, 249236952, 266399985, 204744203, 256161441, 266399682, 255586422, 260338681, 260338738,
                            259884440, 245487674, 260338032, 258405871, 254120565, 241126056, 257484118, 257482860, 227284854, 249695081, 263787869, 258405092,
                            260341085, 260340710, 255643076, 245634619, 260339097, 260341157, 277684109, 260341365, 255989287, 236219513, 256161484, 263909321,
                            258404176, 262604392, 269422868, 241125307, 249236046, 241131779, 255426028, 250544690, 256161309, 234282357, 241003998, 231298050,
                            271082325, 236295507, 231773712, 238990894, 227418570, 234841062, 230534454, 237803386, 257106541, 226651030, 239015822, 248754248,
                            188625203, 241595107, 234841098, 246332555, 236873975, 256998640, 237035667, 252823356, 246082939, 239847368, 238354078, 231691962,
                            239685179, 239685183, 238669813, 255373486, 262603821, 238609025, 250913452, 241679435, 215997336, 238361106, 249166917, 239134844,
                            241083511, 279940948, 239687105, 259750174, 238670767, 255749856, 238373613, 233798438, 270841032, 274255684, 265041380, 255736258,
                            228122339, 244698838, 248127668, 239241828, 239045587, 255651123, 196035878, 243858317, 259286279, 269521474, 249166026, 231434936,
                            255643696, 238305121, 252333024, 239379225, 260810635, 272895621, 255214402, 244821780, 234460272, 226843584, 263266174, 239092991,
                            240742005, 235986635, 247113281, 234282985, 269013633, 253984557, 239171727, 256542963, 236772069, 255957318, 239243645, 260837217,
                            252944267, 235357917, 236350303, 256251839, 244960072, 239301928, 248764192
    );

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
    DBMS_OUTPUT.PUT_LINE('------------- INICIO OSF-1183 -------------');
    
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
    DBMS_OUTPUT.PUT_LINE('------------- FIN OSF-1183 -------------');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error General OSF-1183: '||sqlerrm);
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/