PROMPT Crea Sinonimo a tabla SALDFAVO para LDC_UIATENDEVSALDOFAVOR_PROC
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.SALDFAVO FOR SALDFAVO';
END;
/