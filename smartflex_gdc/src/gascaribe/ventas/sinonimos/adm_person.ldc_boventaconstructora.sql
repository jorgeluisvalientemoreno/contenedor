PROMPT Crea sinonimo objeto dependiente LDC_BOVENTACONSTRUCTORA
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_BOVENTACONSTRUCTORA FOR LDC_BOVENTACONSTRUCTORA';
END;
/