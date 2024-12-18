CREATE OR REPLACE TRIGGER OPEN.TRG_BI_LDC_OSF_COSTINGR
    AFTER INSERT OR UPDATE OR DELETE
    ON OPEN.LDC_OSF_COSTINGR
    REFERENCING OLD AS OLD NEW AS NEW
    FOR EACH ROW
BEGIN

    DECLARE

    ROW_ID             ROWID;
    NUANO_OLD          NUMBER(4);
    NUMES_OLD          NUMBER(2);
    ESTADO_OLD         CHAR(9);
    PRODUCT_ID_OLD     NUMBER(15);
    CATE_OLD           NUMBER(2);
    TIPO_OLD           CHAR(8);
    ACTA_OLD           NUMBER(15);
    FACTURA_OLD        VARCHAR2(50);
    FECHA_OLD          DATE;
    CONTRATISTA_OLD    NUMBER(4);
    NOMBRE_OLD         VARCHAR2(100);
    TITR_OLD           NUMBER(10);
    CUENTA_OLD         VARCHAR2(20);
    NOM_CUENTA_OLD     VARCHAR2(200);
    CLASIFICADOR_OLD   NUMBER(15);
    ACTIVIDAD_OLD      NUMBER(15);
    CONCEPT_OLD        NUMBER(4);
    COSTO_OLD          NUMBER(17, 2);
    IVA_OLD            NUMBER(17, 2);
    ING_OTRO_OLD       NUMBER(17, 2);
    NOTAS_OLD          NUMBER(17, 2);
    ING_INT_MIG_OLD    NUMBER(17, 2);
    ING_CXC_MIG_OLD    NUMBER(17, 2);
    ING_RP_MIG_OLD     NUMBER(17, 2);
    ING_INT_OSF_OLD    NUMBER(17, 2);
    ING_CXC_OSF_OLD    NUMBER(17, 2);
    ING_RP_OSF_OLD     NUMBER(17, 2);
    ING_INT_CON_OLD    NUMBER(17, 2);
    ING_CXC_CON_OLD    NUMBER(17, 2);
    ING_RP_CON_OLD     NUMBER(17, 2);
    TOTAL_INGRESO_OLD  NUMBER(17, 2);
    UTILIDAD_OLD       NUMBER(17, 2);
    MARGEN_OLD         NUMBER(17, 2);
    ORDER_ID_OLD       NUMBER(15);
    NUANO_NEW          NUMBER(4);
    NUMES_NEW          NUMBER(2);
    ESTADO_NEW         CHAR(9);
    PRODUCT_ID_NEW     NUMBER(15);
    CATE_NEW           NUMBER(2);
    TIPO_NEW           CHAR(8);
    ACTA_NEW           NUMBER(15);
    FACTURA_NEW        VARCHAR2(50);
    FECHA_NEW          DATE;
    CONTRATISTA_NEW    NUMBER(4);
    NOMBRE_NEW         VARCHAR2(100);
    TITR_NEW           NUMBER(10);
    CUENTA_NEW         VARCHAR2(20);
    NOM_CUENTA_NEW     VARCHAR2(200);
    CLASIFICADOR_NEW   NUMBER(15);
    ACTIVIDAD_NEW      NUMBER(15);
    CONCEPT_NEW        NUMBER(4);
    COSTO_NEW          NUMBER(17, 2);
    IVA_NEW            NUMBER(17, 2);
    ING_OTRO_NEW       NUMBER(17, 2);
    NOTAS_NEW          NUMBER(17, 2);
    ING_INT_MIG_NEW    NUMBER(17, 2);
    ING_CXC_MIG_NEW    NUMBER(17, 2);
    ING_RP_MIG_NEW     NUMBER(17, 2);
    ING_INT_OSF_NEW    NUMBER(17, 2);
    ING_CXC_OSF_NEW    NUMBER(17, 2);
    ING_RP_OSF_NEW     NUMBER(17, 2);
    ING_INT_CON_NEW    NUMBER(17, 2);
    ING_CXC_CON_NEW    NUMBER(17, 2);
    ING_RP_CON_NEW     NUMBER(17, 2);
    TOTAL_INGRESO_NEW  NUMBER(17, 2);
    UTILIDAD_NEW       NUMBER(17, 2);
    MARGEN_NEW         NUMBER(17, 2);
    ORDER_ID_NEW       NUMBER(15);
    OPERATION          VARCHAR2(1);

    BEGIN

    IF INSERTING THEN
        ROW_ID              := :new.ROWID;
        NUANO_OLD           := NULL;
        NUMES_OLD           := NULL;
        ESTADO_OLD          := NULL;
        PRODUCT_ID_OLD      := NULL;
        CATE_OLD            := NULL;
        TIPO_OLD            := NULL;
        ACTA_OLD            := NULL;
        FACTURA_OLD         := NULL;
        FECHA_OLD           := NULL;
        CONTRATISTA_OLD     := NULL;
        NOMBRE_OLD          := NULL;
        TITR_OLD            := NULL;
        CUENTA_OLD          := NULL;
        NOM_CUENTA_OLD      := NULL;
        CLASIFICADOR_OLD    := NULL;
        ACTIVIDAD_OLD       := NULL;
        CONCEPT_OLD         := NULL;
        COSTO_OLD           := NULL;
        IVA_OLD             := NULL;
        ING_OTRO_OLD        := NULL;
        NOTAS_OLD           := NULL;
        ING_INT_MIG_OLD     := NULL;
        ING_CXC_MIG_OLD     := NULL;
        ING_RP_MIG_OLD      := NULL;
        ING_INT_OSF_OLD     := NULL;
        ING_CXC_OSF_OLD     := NULL;
        ING_RP_OSF_OLD      := NULL;
        ING_INT_CON_OLD     := NULL;
        ING_CXC_CON_OLD     := NULL;
        ING_RP_CON_OLD      := NULL;
        TOTAL_INGRESO_OLD   := NULL;
        UTILIDAD_OLD        := NULL;
        MARGEN_OLD          := NULL;
        ORDER_ID_OLD        := NULL;
        NUANO_NEW           := :new.NUANO;
        NUMES_NEW           := :new.NUMES;
        ESTADO_NEW          := :new.ESTADO;
        PRODUCT_ID_NEW      := :new.PRODUCT_ID;
        CATE_NEW            := :new.CATE;
        TIPO_NEW            := :new.TIPO;
        ACTA_NEW            := :new.ACTA;
        FACTURA_NEW         := :new.FACTURA;
        FECHA_NEW           := :new.FECHA;
        CONTRATISTA_NEW     := :new.CONTRATISTA;
        NOMBRE_NEW          := :new.NOMBRE;
        TITR_NEW            := :new.TITR;
        CUENTA_NEW          := :new.CUENTA;
        NOM_CUENTA_NEW      := :new.NOM_CUENTA;
        CLASIFICADOR_NEW    := :new.CLASIFICADOR;
        ACTIVIDAD_NEW       := :new.ACTIVIDAD;
        CONCEPT_NEW         := :new.CONCEPT;
        COSTO_NEW           := :new.COSTO;
        IVA_NEW             := :new.IVA;
        ING_OTRO_NEW        := :new.ING_OTRO;
        NOTAS_NEW           := :new.NOTAS;
        ING_INT_MIG_NEW     := :new.ING_INT_MIG;
        ING_CXC_MIG_NEW     := :new.ING_CXC_MIG;
        ING_RP_MIG_NEW      := :new.ING_RP_MIG;
        ING_INT_OSF_NEW     := :new.ING_INT_OSF;
        ING_CXC_OSF_NEW     := :new.ING_CXC_OSF;
        ING_RP_OSF_NEW      := :new.ING_RP_OSF;
        ING_INT_CON_NEW     := :new.ING_INT_CON;
        ING_CXC_CON_NEW     := :new.ING_CXC_CON;
        ING_RP_CON_NEW      := :new.ING_RP_CON;
        TOTAL_INGRESO_NEW   := :new.TOTAL_INGRESO;
        UTILIDAD_NEW        := :new.UTILIDAD;
        MARGEN_NEW          := :new.MARGEN;
        ORDER_ID_NEW        := :new.ORDER_ID;
        OPERATION           := 'I';
    ELSIF UPDATING THEN
        ROW_ID              := :new.ROWID;
        NUANO_OLD           := :old.NUANO;
        NUMES_OLD           := :old.NUMES;
        ESTADO_OLD          := :old.ESTADO;
        PRODUCT_ID_OLD      := :old.PRODUCT_ID;
        CATE_OLD            := :old.CATE;
        TIPO_OLD            := :old.TIPO;
        ACTA_OLD            := :old.ACTA;
        FACTURA_OLD         := :old.FACTURA;
        FECHA_OLD           := :old.FECHA;
        CONTRATISTA_OLD     := :old.CONTRATISTA;
        NOMBRE_OLD          := :old.NOMBRE;
        TITR_OLD            := :old.TITR;
        CUENTA_OLD          := :old.CUENTA;
        NOM_CUENTA_OLD      := :old.NOM_CUENTA;
        CLASIFICADOR_OLD    := :old.CLASIFICADOR;
        ACTIVIDAD_OLD       := :old.ACTIVIDAD;
        CONCEPT_OLD         := :old.CONCEPT;
        COSTO_OLD           := :old.COSTO;
        IVA_OLD             := :old.IVA;
        ING_OTRO_OLD        := :old.ING_OTRO;
        NOTAS_OLD           := :old.NOTAS;
        ING_INT_MIG_OLD     := :old.ING_INT_MIG;
        ING_CXC_MIG_OLD     := :old.ING_CXC_MIG;
        ING_RP_MIG_OLD      := :old.ING_RP_MIG;
        ING_INT_OSF_OLD     := :old.ING_INT_OSF;
        ING_CXC_OSF_OLD     := :old.ING_CXC_OSF;
        ING_RP_OSF_OLD      := :old.ING_RP_OSF;
        ING_INT_CON_OLD     := :old.ING_INT_CON;
        ING_CXC_CON_OLD     := :old.ING_CXC_CON;
        ING_RP_CON_OLD      := :old.ING_RP_CON;
        TOTAL_INGRESO_OLD   := :old.TOTAL_INGRESO;
        UTILIDAD_OLD        := :old.UTILIDAD;
        MARGEN_OLD          := :old.MARGEN;
        ORDER_ID_OLD        := :old.ORDER_ID;
        NUANO_NEW           := :new.NUANO;
        NUMES_NEW           := :new.NUMES;
        ESTADO_NEW          := :new.ESTADO;
        PRODUCT_ID_NEW      := :new.PRODUCT_ID;
        CATE_NEW            := :new.CATE;
        TIPO_NEW            := :new.TIPO;
        ACTA_NEW            := :new.ACTA;
        FACTURA_NEW         := :new.FACTURA;
        FECHA_NEW           := :new.FECHA;
        CONTRATISTA_NEW     := :new.CONTRATISTA;
        NOMBRE_NEW          := :new.NOMBRE;
        TITR_NEW            := :new.TITR;
        CUENTA_NEW          := :new.CUENTA;
        NOM_CUENTA_NEW      := :new.NOM_CUENTA;
        CLASIFICADOR_NEW    := :new.CLASIFICADOR;
        ACTIVIDAD_NEW       := :new.ACTIVIDAD;
        CONCEPT_NEW         := :new.CONCEPT;
        COSTO_NEW           := :new.COSTO;
        IVA_NEW             := :new.IVA;
        ING_OTRO_NEW        := :new.ING_OTRO;
        NOTAS_NEW           := :new.NOTAS;
        ING_INT_MIG_NEW     := :new.ING_INT_MIG;
        ING_CXC_MIG_NEW     := :new.ING_CXC_MIG;
        ING_RP_MIG_NEW      := :new.ING_RP_MIG;
        ING_INT_OSF_NEW     := :new.ING_INT_OSF;
        ING_CXC_OSF_NEW     := :new.ING_CXC_OSF;
        ING_RP_OSF_NEW      := :new.ING_RP_OSF;
        ING_INT_CON_NEW     := :new.ING_INT_CON;
        ING_CXC_CON_NEW     := :new.ING_CXC_CON;
        ING_RP_CON_NEW      := :new.ING_RP_CON;
        TOTAL_INGRESO_NEW   := :new.TOTAL_INGRESO;
        UTILIDAD_NEW        := :new.UTILIDAD;
        MARGEN_NEW          := :new.MARGEN;
        ORDER_ID_NEW        := :new.ORDER_ID;
        OPERATION           := 'U';
    ELSE
        ROW_ID              := :old.ROWID;
        NUANO_OLD           := :old.NUANO;
        NUMES_OLD           := :old.NUMES;
        ESTADO_OLD          := :old.ESTADO;
        PRODUCT_ID_OLD      := :old.PRODUCT_ID;
        CATE_OLD            := :old.CATE;
        TIPO_OLD            := :old.TIPO;
        ACTA_OLD            := :old.ACTA;
        FACTURA_OLD         := :old.FACTURA;
        FECHA_OLD           := :old.FECHA;
        CONTRATISTA_OLD     := :old.CONTRATISTA;
        NOMBRE_OLD          := :old.NOMBRE;
        TITR_OLD            := :old.TITR;
        CUENTA_OLD          := :old.CUENTA;
        NOM_CUENTA_OLD      := :old.NOM_CUENTA;
        CLASIFICADOR_OLD    := :old.CLASIFICADOR;
        ACTIVIDAD_OLD       := :old.ACTIVIDAD;
        CONCEPT_OLD         := :old.CONCEPT;
        COSTO_OLD           := :old.COSTO;
        IVA_OLD             := :old.IVA;
        ING_OTRO_OLD        := :old.ING_OTRO;
        NOTAS_OLD           := :old.NOTAS;
        ING_INT_MIG_OLD     := :old.ING_INT_MIG;
        ING_CXC_MIG_OLD     := :old.ING_CXC_MIG;
        ING_RP_MIG_OLD      := :old.ING_RP_MIG;
        ING_INT_OSF_OLD     := :old.ING_INT_OSF;
        ING_CXC_OSF_OLD     := :old.ING_CXC_OSF;
        ING_RP_OSF_OLD      := :old.ING_RP_OSF;
        ING_INT_CON_OLD     := :old.ING_INT_CON;
        ING_CXC_CON_OLD     := :old.ING_CXC_CON;
        ING_RP_CON_OLD      := :old.ING_RP_CON;
        TOTAL_INGRESO_OLD   := :old.TOTAL_INGRESO;
        UTILIDAD_OLD        := :old.UTILIDAD;
        MARGEN_OLD          := :old.MARGEN;
        ORDER_ID_OLD        := :old.ORDER_ID;
        NUANO_NEW           := NULL;
        NUMES_NEW           := NULL;
        ESTADO_NEW          := NULL;
        PRODUCT_ID_NEW      := NULL;
        CATE_NEW            := NULL;
        TIPO_NEW            := NULL;
        ACTA_NEW            := NULL;
        FACTURA_NEW         := NULL;
        FECHA_NEW           := NULL;
        CONTRATISTA_NEW     := NULL;
        NOMBRE_NEW          := NULL;
        TITR_NEW            := NULL;
        CUENTA_NEW          := NULL;
        NOM_CUENTA_NEW      := NULL;
        CLASIFICADOR_NEW    := NULL;
        ACTIVIDAD_NEW       := NULL;
        CONCEPT_NEW         := NULL;
        COSTO_NEW           := NULL;
        IVA_NEW             := NULL;
        ING_OTRO_NEW        := NULL;
        NOTAS_NEW           := NULL;
        ING_INT_MIG_NEW     := NULL;
        ING_CXC_MIG_NEW     := NULL;
        ING_RP_MIG_NEW      := NULL;
        ING_INT_OSF_NEW     := NULL;
        ING_CXC_OSF_NEW     := NULL;
        ING_RP_OSF_NEW      := NULL;
        ING_INT_CON_NEW     := NULL;
        ING_CXC_CON_NEW     := NULL;
        ING_RP_CON_NEW      := NULL;
        TOTAL_INGRESO_NEW   := NULL;
        UTILIDAD_NEW        := NULL;
        MARGEN_NEW          := NULL;
        ORDER_ID_NEW        := NULL;
        OPERATION           := 'D';
    END IF;

    INSERT INTO OPEN.LDCBI_LDC_OSF_COSTINGR (
        ROW_ID,
        NUANO_OLD,
        NUMES_OLD,
        ESTADO_OLD,
        PRODUCT_ID_OLD,
        CATE_OLD,
        TIPO_OLD,
        ACTA_OLD,
        FACTURA_OLD,
        FECHA_OLD,
        CONTRATISTA_OLD,
        NOMBRE_OLD,
        TITR_OLD,
        CUENTA_OLD,
        NOM_CUENTA_OLD,
        CLASIFICADOR_OLD,
        ACTIVIDAD_OLD,
        CONCEPT_OLD,
        COSTO_OLD,
        IVA_OLD,
        ING_OTRO_OLD,
        NOTAS_OLD,
        ING_INT_MIG_OLD,
        ING_CXC_MIG_OLD,
        ING_RP_MIG_OLD,
        ING_INT_OSF_OLD,
        ING_CXC_OSF_OLD,
        ING_RP_OSF_OLD,
        ING_INT_CON_OLD,
        ING_CXC_CON_OLD,
        ING_RP_CON_OLD,
        TOTAL_INGRESO_OLD,
        UTILIDAD_OLD,
        MARGEN_OLD,
        ORDER_ID_OLD,
        NUANO_NEW,
        NUMES_NEW,
        ESTADO_NEW,
        PRODUCT_ID_NEW,
        CATE_NEW,
        TIPO_NEW,
        ACTA_NEW,
        FACTURA_NEW,
        FECHA_NEW,
        CONTRATISTA_NEW,
        NOMBRE_NEW,
        TITR_NEW,
        CUENTA_NEW,
        NOM_CUENTA_NEW,
        CLASIFICADOR_NEW,
        ACTIVIDAD_NEW,
        CONCEPT_NEW,
        COSTO_NEW,
        IVA_NEW,
        ING_OTRO_NEW,
        NOTAS_NEW,
        ING_INT_MIG_NEW,
        ING_CXC_MIG_NEW,
        ING_RP_MIG_NEW,
        ING_INT_OSF_NEW,
        ING_CXC_OSF_NEW,
        ING_RP_OSF_NEW,
        ING_INT_CON_NEW,
        ING_CXC_CON_NEW,
        ING_RP_CON_NEW,
        TOTAL_INGRESO_NEW,
        UTILIDAD_NEW,
        MARGEN_NEW,
        ORDER_ID_NEW,
        OPERATION
    )
    VALUES (
        ROW_ID,
        NUANO_OLD,
        NUMES_OLD,
        ESTADO_OLD,
        PRODUCT_ID_OLD,
        CATE_OLD,
        TIPO_OLD,
        ACTA_OLD,
        FACTURA_OLD,
        FECHA_OLD,
        CONTRATISTA_OLD,
        NOMBRE_OLD,
        TITR_OLD,
        CUENTA_OLD,
        NOM_CUENTA_OLD,
        CLASIFICADOR_OLD,
        ACTIVIDAD_OLD,
        CONCEPT_OLD,
        COSTO_OLD,
        IVA_OLD,
        ING_OTRO_OLD,
        NOTAS_OLD,
        ING_INT_MIG_OLD,
        ING_CXC_MIG_OLD,
        ING_RP_MIG_OLD,
        ING_INT_OSF_OLD,
        ING_CXC_OSF_OLD,
        ING_RP_OSF_OLD,
        ING_INT_CON_OLD,
        ING_CXC_CON_OLD,
        ING_RP_CON_OLD,
        TOTAL_INGRESO_OLD,
        UTILIDAD_OLD,
        MARGEN_OLD,
        ORDER_ID_OLD,
        NUANO_NEW,
        NUMES_NEW,
        ESTADO_NEW,
        PRODUCT_ID_NEW,
        CATE_NEW,
        TIPO_NEW,
        ACTA_NEW,
        FACTURA_NEW,
        FECHA_NEW,
        CONTRATISTA_NEW,
        NOMBRE_NEW,
        TITR_NEW,
        CUENTA_NEW,
        NOM_CUENTA_NEW,
        CLASIFICADOR_NEW,
        ACTIVIDAD_NEW,
        CONCEPT_NEW,
        COSTO_NEW,
        IVA_NEW,
        ING_OTRO_NEW,
        NOTAS_NEW,
        ING_INT_MIG_NEW,
        ING_CXC_MIG_NEW,
        ING_RP_MIG_NEW,
        ING_INT_OSF_NEW,
        ING_CXC_OSF_NEW,
        ING_RP_OSF_NEW,
        ING_INT_CON_NEW,
        ING_CXC_CON_NEW,
        ING_RP_CON_NEW,
        TOTAL_INGRESO_NEW,
        UTILIDAD_NEW,
        MARGEN_NEW,
        ORDER_ID_NEW,
        OPERATION
    );

    EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20000,
                                'Error en TRG_DE_LDC_OSF_COSTINGR por -->' || sqlcode ||
                                chr(13) || sqlerrm);
    END;

END;
/