PROMPT ARCHIVO pkaccountmgr.sql
PROMPT CREA SINONIMO PAQUETE PKACCOUNTMGR
BEGIN
  pkg_utilidades.prCrearSinonimos('PKACCOUNTMGR','OPEN');
END;
/