-- Create table
CREATE TABLE OPEN.LDCBI_LDC_OSF_COSTINGR
(
    ROW_ID             ROWID,
    NUANO_OLD          NUMBER(4),
    NUMES_OLD          NUMBER(2),
    ESTADO_OLD         CHAR(9),
    PRODUCT_ID_OLD     NUMBER(15),
    CATE_OLD           NUMBER(2),
    TIPO_OLD           CHAR(8),
    ACTA_OLD           NUMBER(15),
    FACTURA_OLD        VARCHAR2(50),
    FECHA_OLD          DATE,
    CONTRATISTA_OLD    NUMBER(4),
    NOMBRE_OLD         VARCHAR2(100),
    TITR_OLD           NUMBER(10),
    CUENTA_OLD         VARCHAR2(20),
    NOM_CUENTA_OLD     VARCHAR2(200),
    CLASIFICADOR_OLD   NUMBER(15),
    ACTIVIDAD_OLD      NUMBER(15),
    CONCEPT_OLD        NUMBER(4),
    COSTO_OLD          NUMBER(17, 2),
    IVA_OLD            NUMBER(17, 2),
    ING_OTRO_OLD       NUMBER(17, 2),
    NOTAS_OLD          NUMBER(17, 2),
    ING_INT_MIG_OLD    NUMBER(17, 2),
    ING_CXC_MIG_OLD    NUMBER(17, 2),
    ING_RP_MIG_OLD     NUMBER(17, 2),
    ING_INT_OSF_OLD    NUMBER(17, 2),
    ING_CXC_OSF_OLD    NUMBER(17, 2),
    ING_RP_OSF_OLD     NUMBER(17, 2),
    ING_INT_CON_OLD    NUMBER(17, 2),
    ING_CXC_CON_OLD    NUMBER(17, 2),
    ING_RP_CON_OLD     NUMBER(17, 2),
    TOTAL_INGRESO_OLD  NUMBER(17, 2),
    UTILIDAD_OLD       NUMBER(17, 2),
    MARGEN_OLD         NUMBER(17, 2),
    ORDER_ID_OLD       NUMBER(15),
    NUANO_NEW          NUMBER(4),
    NUMES_NEW          NUMBER(2),
    ESTADO_NEW         CHAR(9),
    PRODUCT_ID_NEW     NUMBER(15),
    CATE_NEW           NUMBER(2),
    TIPO_NEW           CHAR(8),
    ACTA_NEW           NUMBER(15),
    FACTURA_NEW        VARCHAR2(50),
    FECHA_NEW          DATE,
    CONTRATISTA_NEW    NUMBER(4),
    NOMBRE_NEW         VARCHAR2(100),
    TITR_NEW           NUMBER(10),
    CUENTA_NEW         VARCHAR2(20),
    NOM_CUENTA_NEW     VARCHAR2(200),
    CLASIFICADOR_NEW   NUMBER(15),
    ACTIVIDAD_NEW      NUMBER(15),
    CONCEPT_NEW        NUMBER(4),
    COSTO_NEW          NUMBER(17, 2),
    IVA_NEW            NUMBER(17, 2),
    ING_OTRO_NEW       NUMBER(17, 2),
    NOTAS_NEW          NUMBER(17, 2),
    ING_INT_MIG_NEW    NUMBER(17, 2),
    ING_CXC_MIG_NEW    NUMBER(17, 2),
    ING_RP_MIG_NEW     NUMBER(17, 2),
    ING_INT_OSF_NEW    NUMBER(17, 2),
    ING_CXC_OSF_NEW    NUMBER(17, 2),
    ING_RP_OSF_NEW     NUMBER(17, 2),
    ING_INT_CON_NEW    NUMBER(17, 2),
    ING_CXC_CON_NEW    NUMBER(17, 2),
    ING_RP_CON_NEW     NUMBER(17, 2),
    TOTAL_INGRESO_NEW  NUMBER(17, 2),
    UTILIDAD_NEW       NUMBER(17, 2),
    MARGEN_NEW         NUMBER(17, 2),
    ORDER_ID_NEW       NUMBER(15),
    OPERATION          VARCHAR2(1),
    PROCESS_STATUS     NUMBER(3) DEFAULT -1,
    CREATED_DATE       DATE      DEFAULT SYSDATE
);

-- Create/Recreate indexes
CREATE index OPEN.IDX_COSTINGR ON OPEN.LDCBI_LDC_OSF_COSTINGR (PROCESS_STATUS, CREATED_DATE);
CREATE index OPEN.IDX_COSTINGR_PRST ON OPEN.LDCBI_LDC_OSF_COSTINGR (PROCESS_STATUS);

-- Grant/Revoke object privileges
GRANT SELECT, INSERT, UPDATE, DELETE ON OPEN.LDCBI_LDC_OSF_COSTINGR TO INNOVACION;
GRANT SELECT, INSERT, UPDATE, DELETE ON OPEN.LDCBI_LDC_OSF_COSTINGR TO INNOVACIONBI;