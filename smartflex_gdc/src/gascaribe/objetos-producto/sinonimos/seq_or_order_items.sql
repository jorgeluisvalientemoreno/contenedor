PROMPT Crea sinonimos privados para adm_person.seq_or_order_items
BEGIN
  pkg_utilidades.prCrearSinonimos(upper('seq_or_order_items'),'OPEN');
END;
/