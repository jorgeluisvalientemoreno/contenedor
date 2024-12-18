PROMPT Crea Sinonimo LDCI_PKWEBSERVUTILS
BEGIN
  pkg_utilidades.prCrearSinonimos('LDCI_PKWEBSERVUTILS', 'ADM_PERSON');
  dbms_output.put_line('Sinonimos de la tabla ADM_PERSON.LDCI_PKWEBSERVUTILS Ok.');
END;
/