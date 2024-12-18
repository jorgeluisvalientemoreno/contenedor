CREATE OR REPLACE TRIGGER usergis1.AFTER_LOGON_TRG
                        AFTER LOGON
                        ON usergis1.SCHEMA
                        DECLARE
                        BEGIN
                            DBMS_APPLICATION_INFO.set_module(USER, 'Initialized');
                            EXECUTE IMMEDIATE 'ALTER SESSION SET current_schema=GISPETI';
                        END;
/
