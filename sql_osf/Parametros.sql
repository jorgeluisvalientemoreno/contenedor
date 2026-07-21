--Parametros Numericos
select l.*, rowid from open.ld_parameter l where l.numeric_value in (10004,10005);
select a.*, rowid from PERSONALIZACIONES.PARAMETROS a where a.valor_numerico in (10004,10005);
select l.*, rowid from open.ldc_pararepe l where l.parevanu in (10004,10005);

--Parametros Cadena
select l.*, rowid from open.ld_parameter l where upper(l.value_chain) like upper('%generada%');
select a.*, rowid from PERSONALIZACIONES.PARAMETROS a where upper(a.valor_cadena) like upper('%generada%');
select l.*, rowid from open.ldc_pararepe l where upper(l.paravast) like upper('%generada%');
