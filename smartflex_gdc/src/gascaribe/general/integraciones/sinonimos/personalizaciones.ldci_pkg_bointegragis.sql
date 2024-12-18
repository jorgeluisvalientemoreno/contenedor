PROMPT Creando Sinonimos para LDCI_PKG_BOINTEGRAGIS
BEGIN
  pkg_utilidades.prCrearSinonimos('LDCI_PKG_BOINTEGRAGIS', 'PERSONALIZACIONES');
  dbms_output.put_line('Sinonimos de la tabla PERSONALIZACIONES.LDCI_PKG_BOINTEGRAGIS Ok.');
END;
/