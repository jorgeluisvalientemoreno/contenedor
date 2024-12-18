CREATE OR REPLACE TRIGGER sys.cdc_drop_ctable_before
  BEFORE
    DROP ON DATABASE
    BEGIN
      /* NOP UNLESS A TABLE OBJECT */
      IF dictionary_obj_type = 'TABLE'
      THEN
        sys.dbms_cdc_ipublish.change_table_trigger(dictionary_obj_owner,dictionary_obj_name,sysevent);
      END IF;
      END;
/
