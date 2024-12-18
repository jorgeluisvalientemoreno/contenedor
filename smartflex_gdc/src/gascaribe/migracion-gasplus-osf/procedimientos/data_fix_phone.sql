CREATE OR REPLACE PROCEDURE data_fix_phone AS

    CURSOR cuClientes
    IS
        SELECT *
        FROM ge_subscriber
        WHERE phone IS not null;

    CURSOR cuPhone(nuSubscriber number)
    IS
        SELECT *
        FROM ge_subs_phone
        WHERE phone_type_id = 4
        AND subscriber_id = nuSubscriber;

    rgPhone     cuPhone%rowtype;
    nuLogError number;

BEGIN

    for rgCliente in cuClientes loop
        BEGIN

            rgPhone.SUBS_PHONE_ID := null;
            open cuPhone(rgCliente.subscriber_id);
            fetch cuPhone INTO rgPhone;
            close cuPhone;

            if rgPhone.SUBS_PHONE_ID IS not null then

                UPDATE GE_SUBS_PHONE
                    SET phone_type_id = 3,
                        PHONE = rgCliente.phone
                    WHERE SUBS_PHONE_ID = rgPhone.SUBS_PHONE_ID;
                commit;

            else

                INSERT /*+ APPEND*/into GE_SUBS_PHONE
                    VALUES (rgCliente.subscriber_id,SEQ_GE_SUBS_PHONE.nextval,rgCliente.phone,NULL,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
                commit;

            END if;

        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
               --PKLOG_MIGRACION.prInsLogMigra ( 333,333,2,'data_fix_phone',0,0,'Error: '||sqlerrm,to_char(sqlcode),nuLogError);
        END;
    END loop;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        --PKLOG_MIGRACION.prInsLogMigra ( 333,333,2,'data_fix_phone',0,0,'Error: '||sqlerrm,to_char(sqlcode),nuLogError);
END;
/
