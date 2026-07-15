SET SERVEROUTPUT ON
/
DECLARE
    sbTable VARCHAR2(4000) := '' || 
    sbProgram VARCHAR2(4000) := 'PRDLOAD_' || sbTable;
BEGIN
 
    DBMS_OUTPUT.PUT_LINE('BEGIN ' || sbProgram);
    MIGRAGG.PKGPROC_MIGR_MGR.PRINSLOGPROC(
            ISBLPMPROG => sbProgram,
            INULPMHILO => 1,
            ISBLPMOBSE => 'Inicia Proceso Carga '||sbProgram||' '||TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),
            INULPMREAP => 0,
            INULPMREPR => 0,
            INULPMREER => 0
            );
    EXECUTE IMMEDIATE 'BEGIN MIGRAGG.' || sbProgram || '; END;';
    DBMS_OUTPUT.PUT_LINE('END ' || sbProgram);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
END;
/