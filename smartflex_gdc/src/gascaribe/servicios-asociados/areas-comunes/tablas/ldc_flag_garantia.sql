DECLARE
    nuTab1 number := 0;
BEGIN
    select count(1)
    into nuTab1
    from dba_objects
    where object_name = 'LDC_FLAG_GARANTIA';

    IF (nuTab1=0) THEN

      execute immediate 'CREATE TABLE "OPEN"."LDC_FLAG_GARANTIA"
                        ("ORDER_ID" NUMBER(15,0) NOT NULL ENABLE,
                         "FLAG_GARANT" VARCHAR2(1))';
                        
     dbms_output.put_line('Tabla LDC_FLAG_GARANTIA creada correctamente');
     
     execute immediate 'ALTER TABLE "OPEN"."LDC_FLAG_GARANTIA" ADD CONSTRAINT
                        "PK_LDC_FLAG_GARANTIA" PRIMARY KEY ("ORDER_ID")
                        USING INDEX ENABLE';

     dbms_output.put_line('Llave primaria creada correctamente');

    END IF;
    -----------------------------------------------------------------------------------------------------
    commit;
END;
/