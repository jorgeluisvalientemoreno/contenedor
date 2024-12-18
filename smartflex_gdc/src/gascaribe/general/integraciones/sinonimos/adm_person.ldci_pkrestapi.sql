PROMPT Crea Sinonimo a LDCI_PKRESTAPI
BEGIN
  pkg_utilidades.prCrearSinonimos('LDCI_PKRESTAPI', 'ADM_PERSON');
  dbms_output.put_line('Sinonimos de la tabla ADM_PERSON.LDCI_PKRESTAPI Ok.');
END;
/
