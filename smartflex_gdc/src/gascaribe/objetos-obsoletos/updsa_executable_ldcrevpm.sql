BEGIN
    UPDATE SA_EXECUTABLE
    SET description = 'NO USAR - Regeneracion Masiva de Revision Periodica'
    WHERE NAME = 'LDCREVPM';
    COMMIT;
END;
/