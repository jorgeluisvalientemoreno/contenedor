Begin 
 execute immediate 'CREATE OR REPLACE SYNONYM adm_person.ldci_infgestotmov for LDCI_INFGESTOTMOV';
End; 
/ 
PROMPT Creando Sinónimos privados para LDCI_ITEMTMP
BEGIN
    pkg_utilidades.prCrearSinonimos( 'LDCI_ITEMTMP', 'OPEN');
END;
/