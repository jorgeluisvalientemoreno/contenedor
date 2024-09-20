DECLARE

  nuObjectId    number;

  CURSOR validaTabla
  IS
      select object_id
      from dba_objects
      where object_name = 'LDCI_OIPRDGENERICO'
      and object_type = 'TABLE';

  sbSQLtabla    varchar2(3000):=
      'create table open.LDCI_OIPRDGENERICO
      (
        clcocodi    NUMBER(15,0),
        clcocate    NUMBER(2,0) not null,
        clcoorin    VARCHAR2(10 BYTE) not null,
        clcciclo    NUMBER(4,0),
        clcoprov    VARCHAR2(1 BYTE) not null
      )';

      typeCursor validaTabla%rowtype;
      
BEGIN

    --dbms_output.put_line('inicio');
    OPEN validaTabla;
    Fetch validaTabla INTO nuObjectId;
    
    IF validaTabla%NOTFOUND or nuObjectId is null THEN

        execute immediate sbSQLtabla;
        -- Alter Table Primary key
        execute immediate 'ALTER TABLE open.LDCI_OIPRDGENERICO
                          ADD CONSTRAINT PK_LDCI_OIPRDGENERICO PRIMARY KEY (clcocodi, clcciclo)
                          USING INDEX  ENABLE';
        -- Add comments to the table
        execute immediate 'comment on table open.LDCI_OIPRDGENERICO
                           is ''Orden Interna Producto Generico''';
        -- Add comments to the columns
        execute immediate 'comment on column LDCI_OIPRDGENERICO.clcocodi
                           is ''Codigo Clasificador''';
        execute immediate 'comment on column LDCI_OIPRDGENERICO.clcocate
                           is ''Codigo Categoria''';
        execute immediate 'comment on column LDCI_OIPRDGENERICO.clcoorin
                           is ''Orden Interna''';
        execute immediate 'comment on column LDCI_OIPRDGENERICO.clcciclo
                           is ''Ciclo''';
        execute immediate 'comment on column LDCI_OIPRDGENERICO.clcoprov
                           is ''Provisiona? (Y/N)''';
        -- Grant/Revoke object privileges
        execute immediate 'grant select, insert, update, delete on LDCI_OIPRDGENERICO to SYSTEM_OBJ_PRIVS_ROLE';
        execute immediate 'grant insert, update, delete on LDCI_OIPRDGENERICO to RDMLOPEN';
        execute immediate 'grant select on LDCI_OIPRDGENERICO to RSELOPEN';
        execute immediate 'grant select on LDCI_OIPRDGENERICO to RSELSYS';

    END IF;
    CLOSE validaTabla;

END;
/