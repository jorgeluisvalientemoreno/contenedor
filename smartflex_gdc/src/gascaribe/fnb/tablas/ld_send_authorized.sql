/*****************************************************************
Propiedad intelectual de Efigas S.A. E.S.P. 

Nombre: ld_send_authorized.sql
Descripción: script para la creación de la tabla ld_send_authorized

Historia de Modificaciones
Fecha           Autor.                  Modificación
-----------     -------------------     -------------------------------------
12-06-2025      Paola Acosta            OSF-4507: Actualizacion de la llave primaria de la entidad LD_SEND_AUTHORIZED 
******************************************************************/ 
DECLARE    
    nuExisteTabla    NUMBER;
    nuExistePK       NUMBER; 
    nuExistePKCampos NUMBER;
    nuExisteFK       NUMBER;
    nuExisteCK_1     NUMBER;  
    nuExisteCK_2     NUMBER;
    
    nuerror          NUMBER;
    sberror          VARCHAR2(4000);
    
    --Constantes
    csbTabla         VARCHAR2(100) := 'LD_SEND_AUTHORIZED';
    
BEGIN
    
    SELECT COUNT(*) INTO nuExisteTabla
    FROM dba_tables
    WHERE table_name = csbTabla 
      AND owner = 'OPEN';
    
    IF nuExisteTabla = 0 THEN
        -- Create table
        EXECUTE IMMEDIATE 'create table OPEN.LD_SEND_AUTHORIZED
                        (
                            ident_type_id    NUMBER(4) not null,
                            identification   VARCHAR2(20) not null,
                            authorized       VARCHAR2(1) not null,
                            type_product_id  NUMBER(4) not null,
                            modif_user_id    NUMBER(15),
                            modif_date       DATE,
                            tipo_responsable CHAR(1) default ''A'' not null,
                            causal           NUMBER(4) not null,
                            product_id       NUMBER(15),
                            sample_id        NUMBER(15) default -1
                        )
                            tablespace TSD_DEFAULT
                            pctfree 10
                            initrans 1
                            maxtrans 255
                            storage
                        (
                            initial 2M
                            next 2M
                            minextents 1
                            maxextents unlimited
                            pctincrease 0
                        )';
        -- Add comments to the table 
        EXECUTE IMMEDIATE q'#comment on table OPEN.LD_SEND_AUTHORIZED 
                            is 'Clientes que han autorizado o no su reporte a las centrales de riesgo'#';
        
        -- Add comments to the columns 
        EXECUTE IMMEDIATE q'#comment on column OPEN.LD_SEND_AUTHORIZED.ident_type_id
                            is 'Codigo del tipo de identificacion'#';
        EXECUTE IMMEDIATE q'#comment on column OPEN.LD_SEND_AUTHORIZED.identification
                            is 'Numero de identificacion'#';
        EXECUTE IMMEDIATE q'#comment on column OPEN.LD_SEND_AUTHORIZED.authorized
                            is 'Indica si el cliente dio su autorizacion para ser reportado a las centrales de riesgo'#';
        EXECUTE IMMEDIATE q'#comment on column OPEN.LD_SEND_AUTHORIZED.type_product_id
                            is 'Tipo de producto'#';
        EXECUTE IMMEDIATE q'#comment on column OPEN.LD_SEND_AUTHORIZED.modif_user_id
                            is 'Ultimo usuario que cambia el valor del campo authorization'#';
        EXECUTE IMMEDIATE q'#comment on column OPEN.LD_SEND_AUTHORIZED.modif_date
                            is 'Fecha en que se realizo el ultiimo cambio al campo authorization'#';
        EXECUTE IMMEDIATE q'#comment on column OPEN.LD_SEND_AUTHORIZED.tipo_responsable
                            is 'Tipo de responsable (A-Ambos, D-Deudor, C-Codeudor)'#';
        EXECUTE IMMEDIATE q'#comment on column OPEN.LD_SEND_AUTHORIZED.causal
                            is 'Causal'#';
        EXECUTE IMMEDIATE q'#comment on column OPEN.LD_SEND_AUTHORIZED.product_id
                            is 'Producto'#';
        EXECUTE IMMEDIATE q'#comment on column OPEN.LD_SEND_AUTHORIZED.sample_id
                            is 'Nro del reporte''#';     
        
        BEGIN
           pkg_utilidades.prAplicarPermisos(csbTabla, 'OPEN');
        END; 
        dbms_output.put_line('Se crea la tabla '||csbTabla);
    ELSE
        dbms_output.put_line('No se crea la tabla '||csbTabla||' ya existe.');
    END IF;
      
    --validacion creación llave primaria
    SELECT COUNT(*)
    INTO nuExistePK
    FROM SYS.all_constraints
    WHERE constraint_name = 'SEND_AUTHORIZED_PK';
    
    IF nuExistePK = 0 THEN
        -- Create/Recreate primary, unique and foreign key constraints 
        EXECUTE IMMEDIATE 'ALTER TABLE OPEN.ld_send_authorized
        ADD CONSTRAINT send_authorized_pk PRIMARY KEY (IDENT_TYPE_ID, IDENTIFICATION, PRODUCT_ID)
        USING INDEX 
            TABLESPACE tsi_default
            PCTFREE 10
            INITRANS 2
            MAXTRANS 255
            STORAGE
        (
            INITIAL 2M
            NEXT 2M
            MINEXTENTS 1
            MAXEXTENTS UNLIMITED
            PCTINCREASE 0
        )';  
        
        dbms_output.put_line('Se crea la PK SEND_AUTHORIZED_PK');
    ELSE
        
        dbms_output.put_line('Existe PK SEND_AUTHORIZED_PK, se validan sus campos');
        --Valida los campos que conforman la pk
        SELECT count(*)
        INTO nuExistePKCampos
        FROM SYS.all_cons_columns
        WHERE table_name = csbTabla
        AND constraint_name = 'SEND_AUTHORIZED_PK'
        AND column_name IN ('IDENT_TYPE_ID','IDENTIFICATION','PRODUCT_ID');
        
        IF nuExistePKCampos < 3 THEN
            EXECUTE IMMEDIATE 'ALTER TABLE LD_SEND_AUTHORIZED DROP CONSTRAINT SEND_AUTHORIZED_PK';
           
            EXECUTE IMMEDIATE 'ALTER TABLE OPEN.ld_send_authorized
            ADD CONSTRAINT send_authorized_pk PRIMARY KEY (IDENT_TYPE_ID, IDENTIFICATION, PRODUCT_ID)
            USING INDEX 
                TABLESPACE tsi_default
                PCTFREE 10
                INITRANS 2
                MAXTRANS 255
                STORAGE
            (
                INITIAL 2M
                NEXT 2M
                MINEXTENTS 1
                MAXEXTENTS UNLIMITED
                PCTINCREASE 0
            )';
            
            dbms_output.put_line('Campos diferentes a los esperados, se actuliza PK');
        ELSE
            dbms_output.put_line('Campos iguales a los esperados, no se actualiza PK');
        END IF;
        
    END IF;
    
    --Validacion creación fk
    SELECT COUNT(*)
    INTO nuExisteFK
    FROM SYS.all_constraints
    WHERE constraint_name = 'SEND_AUTHORIZED_FK';

    IF nuExisteFK = 0 THEN
        EXECUTE IMMEDIATE 'alter table OPEN.LD_SEND_AUTHORIZED
                           add constraint SEND_AUTHORIZED_FK foreign key (CAUSAL)
                           references OPEN.GE_CAUSAL (CAUSAL_ID)';
        dbms_output.put_line('No existe FK SEND_AUTHORIZED_FK, se crea');                           
    ELSE
        dbms_output.put_line('Existe FK SEND_AUTHORIZED_FK, no se crea'); 
    END IF;

    -- Create/Recreate check constraints     
    --Validacion creación de CK
    SELECT COUNT(*)
    INTO nuExisteCK_1
    FROM SYS.all_constraints
    WHERE constraint_name = 'SEND_AUTHORIZED_CHK_01';
    
    IF nuExisteCK_1 = 0 THEN
        EXECUTE IMMEDIATE q'#alter table OPEN.LD_SEND_AUTHORIZED
                          add constraint SEND_AUTHORIZED_CHK_01
                          check (AUTHORIZED in ('S', 'N'))#';
        dbms_output.put_line('No existe CHK SEND_AUTHORIZED_CHK_01, se crea');
    ELSE
        dbms_output.put_line('Existe CHK SEND_AUTHORIZED_CHK_01, no se crea');
    END IF;
    
    SELECT COUNT(*)
    INTO nuExisteCK_2
    FROM SYS.all_constraints
    WHERE constraint_name = 'SEND_AUTHORIZED_CHK_02';
    
    IF nuExisteCK_2 = 0 THEN
        EXECUTE IMMEDIATE q'#alter table OPEN.LD_SEND_AUTHORIZED
                          add constraint SEND_AUTHORIZED_CHK_02
                          check (tipo_responsable in ('A', 'D', 'C'))#';
        dbms_output.put_line('No existe CHK SEND_AUTHORIZED_CHK_02, se crea');
    ELSE
        dbms_output.put_line('Existe CHK SEND_AUTHORIZED_CHK_02, no se crea');
    END IF;
    
EXCEPTION
    WHEN OTHERS THEN
        pkg_error.seterror;
        pkg_error.geterror(nuerror, sberror);
        dbms_output.put_line('sbError => ' || sberror);
        RAISE pkg_error.controlled_error;
END;
/