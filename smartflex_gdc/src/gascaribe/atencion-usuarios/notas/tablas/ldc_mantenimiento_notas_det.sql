declare
    sbTabla     constant varchar2(200) := 'LDC_MANTENIMIENTO_NOTAS_DET';
    sbEsquema   varchar2(200) := 'OPEN';
    nuconta     number;
begin
    sbEsquema := nvl(sbEsquema,'OPEN');
    SELECT COUNT(1) INTO nuconta
    FROM DBA_TABLES T
    WHERE T.TABLE_NAME = sbTabla
    AND T.OWNER = sbEsquema;
    
    IF nuconta = 0 THEN  
        -- Create table
        EXECUTE IMMEDIATE 
        'create table OPEN.LDC_MANTENIMIENTO_NOTAS_DET
        (
          cuenta_cobro NUMBER(10),
          producto     NUMBER(10),
          concepto     NUMBER(4),
          signo        VARCHAR2(2),
          valor        NUMBER(13,2),
          sesion       NUMBER,
          causa_cargo  NUMBER(2)
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
        EXECUTE IMMEDIATE 'COMMENT ON TABLEOPEN.LDC_MANTENIMIENTO_NOTAS_DET IS ''Cargos a crear en la aprobacion''';
        -- Add comments to the columns 
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_MANTENIMIENTO_NOTAS_DET.cuenta_cobro               IS ''Cuetna de Cobro''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_MANTENIMIENTO_NOTAS_DET.producto               IS ''Servicio Suscrito''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_MANTENIMIENTO_NOTAS_DET.concepto               IS ''Concepto''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_MANTENIMIENTO_NOTAS_DET.signo               IS ''signo''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_MANTENIMIENTO_NOTAS_DET.valor               IS ''Valor del Cargo''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_MANTENIMIENTO_NOTAS_DET.sesion               IS ''Sesion''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_MANTENIMIENTO_NOTAS_DET.causa_cargo               IS ''Causa cargo''';
        ---- Grant/Revoke object privileges         
        EXECUTE IMMEDIATE 'grant insert, update, delete on OPEN.LDC_MANTENIMIENTO_NOTAS_DET to RDMLOPEN';
        EXECUTE IMMEDIATE 'grant select, insert, update, delete on OPEN.LDC_MANTENIMIENTO_NOTAS_DET to REPORTES';
        EXECUTE IMMEDIATE 'grant select on OPEN.LDC_MANTENIMIENTO_NOTAS_DET to ROLESELOPEN';
        EXECUTE IMMEDIATE 'grant select on OPEN.LDC_MANTENIMIENTO_NOTAS_DET to RSELOPEN';
        EXECUTE IMMEDIATE 'grant select on OPEN.LDC_MANTENIMIENTO_NOTAS_DET to RSELSYS';
        EXECUTE IMMEDIATE 'grant select on OPEN.LDC_MANTENIMIENTO_NOTAS_DET to RSELUSELOPEN';
        EXECUTE IMMEDIATE 'grant select, insert, update, delete on OPEN.LDC_MANTENIMIENTO_NOTAS_DET to SYSTEM_OBJ_PRIVS_ROLE';
        
    ELSE
        dbms_output.put_line('Tabla '||sbEsquema||'.'||sbTabla||' ya existe');
    END IF;
end;
/

/***********************************************************
ELABORADO POR:  Juan Gabriel Catuche Giron
EMPRESA:        MVM Ingenieria de Software
FECHA:          Septiembre 2024 
JIRA:           OSF-3332

    Adición de campo para valor base en la tabla temporal usada por MANOT

    --Modificaciones    
    Fecha           Autor           Descripción
    25/09/2024      jcatuche        OSF-3332: Creación
    
***********************************************************/
Declare
    
    sbTabla     constant varchar2(200) := 'LDC_MANTENIMIENTO_NOTAS_DET';
    sbColumna   constant varchar2(200) := 'VALOR_BASE';
    
    sbEsquema   varchar2(200) := 'OPEN';
    nuconta     number;
BEGIN

    sbEsquema := nvl(sbEsquema,'OPEN');
    SELECT COUNT(1) INTO nuconta
    FROM DBA_TABLES T
    WHERE T.TABLE_NAME = sbTabla
    AND T.OWNER = sbEsquema;

    IF nuconta = 1 THEN  
    
        select count(*) into nuconta
        from all_tab_columns c
        where c.table_name = sbTabla
        and c.column_name = sbColumna
        and c.owner = sbEsquema;
        
        IF nuconta = 0 THEN
            dbms_output.put_line('Adición columna '||sbColumna||' en tabla '||sbEsquema||'.'||sbTabla);   
            EXECUTE IMMEDIATE 'ALTER TABLE '||sbEsquema||'.'||sbTabla||' ADD '||sbColumna||' NUMBER(13,2)';
            EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||sbEsquema||'.'||sbTabla||'.'||sbColumna||' IS ''Valor base del cargo''';
        ELSE
            dbms_output.put_line('Columna '||sbColumna||' de '||sbEsquema||'.'||sbTabla||' ya existe');
            EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||sbEsquema||'.'||sbTabla||'.'||sbColumna||' IS ''Valor base del cargo''';
        END IF;
    ELSE
        dbms_output.put_line('Tabla '||sbEsquema||'.'||sbTabla||' no existe');
    END IF;

END;
/
