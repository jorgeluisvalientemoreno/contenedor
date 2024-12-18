PROMPT Crea Sinonimo a tabla fblaplicaentrega
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.fblaplicaentrega FOR fblaplicaentrega';
END;
/