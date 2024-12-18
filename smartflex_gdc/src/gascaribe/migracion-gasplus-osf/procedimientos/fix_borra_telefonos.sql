CREATE OR REPLACE PROCEDURE fix_borra_telefonos as

    CURSOR cuClientes
    IS
        SELECT subscriber_id,phone_type_id,phone, count(*) cant
        FROM ge_subs_phone
        GROUP BY subscriber_id,phone_type_id,phone
        HAVING count(*) > 1
        ORDER BY count(*) desc;
        
    CURSOR cuPhone(nuClie number, nuPhone number, nuTipo number)
    IS
        SELECT *
        FROM ge_subs_phone
        WHERE subscriber_id = nuClie
        AND phone_type_id = nuTipo
        AND phone = nuPhone;
        
    rgPhone     cuPhone%rowtype;

    nuI number;
    nuLogError number;

BEGIN

    for rgCliente in cuClientes loop
    
        nuI := rgCliente.cant;
        --dbms_output.put_Line('cantidad: '||nuI);
        WHILE nuI > 1 LOOP
            BEGIN

                open cuPhone(rgCliente.subscriber_id,rgCliente.phone,rgCliente.phone_type_id);
                fetch cuPhone INTO rgPhone;
                close cuPhone;

                DELETE FROM ge_subs_phone
                    WHERE subs_phone_id = rgPhone.subs_phone_id;

                nuI := nuI - 1;
                commit;
                EXCEPTION
                    when others then
                        rollback;
                        --PKLOG_MIGRACION.prInsLogMigra ( 555,555,2,'BORRA_TELEFONOS',0,0,'Error: '||sqlerrm,to_char(sqlcode),nuLogError);
            END;
	    END LOOP;
    END loop;

EXCEPTION
    when others then
        rollback;
        --PKLOG_MIGRACION.prInsLogMigra ( 555,555,2,'BORRA_TELEFONOS',0,0,'Error: '||sqlerrm,to_char(sqlcode),nuLogError);
END;
/
