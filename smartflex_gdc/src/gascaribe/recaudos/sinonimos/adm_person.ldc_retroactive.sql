PROMPT Crea sinonimo objeto dependiente LDC_RETROACTIVE
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_RETROACTIVE FOR LDC_RETROACTIVE';
END;
/