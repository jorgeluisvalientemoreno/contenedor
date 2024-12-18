declare

    nuExiste number;
begin

    select count(1)
      into nuExiste
      from dba_tables 
      where table_name='OMITIR_FACTURA_TEMP'
        and owner='PERSONALIZACIONES';

    if nuExiste = 0 then
        EXECUTE IMMEDIATE 'CREATE TABLE PERSONALIZACIONES.OMITIR_FACTURA_TEMP ( IDCONTRATO NUMBER(15) NOT NULL,
                                                                               CONDICION VARCHAR2(2) NOT NULL)
                           tablespace TSD_DATOS
                            pctfree 5
                            initrans 2
                            maxtrans 255
                            storage
                            (
                                initial 20M
                                next 20M
                                minextents 1
                                maxextents unlimited
                                pctincrease 0
                            )';
        EXECUTE IMMEDIATE q'#ALTER TABLE PERSONALIZACIONES.OMITIR_FACTURA_TEMP ADD CONSTRAINT PK_OMITIR_FACTURA_TEMP PRIMARY KEY(IDCONTRATO)#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN PERSONALIZACIONES.OMITIR_FACTURA_TEMP.IDCONTRATO IS 'Identificador del contrato'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN PERSONALIZACIONES.OMITIR_FACTURA_TEMP.CONDICION IS 'Excluye Y / No se Excluye N'#';
        EXECUTE IMMEDIATE q'#COMMENT ON TABLE PERSONALIZACIONES.OMITIR_FACTURA_TEMP IS 'Tabla para excluir contratos del control de horario para facturar'#';
        EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE, DELETE ON PERSONALIZACIONES.OMITIR_FACTURA_TEMP TO INNOVACION';
        EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE, DELETE ON PERSONALIZACIONES.OMITIR_FACTURA_TEMP TO RDLBRILLAAPP';
        BEGIN
            pkg_utilidades.prAplicarPermisos('OMITIR_FACTURA_TEMP','PERSONALIZACIONES');
        END;
    end if;
END;
/


