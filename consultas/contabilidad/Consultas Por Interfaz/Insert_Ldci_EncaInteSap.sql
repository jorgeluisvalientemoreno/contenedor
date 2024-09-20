prompt Importing table open.ldci_encaintesap...
set feedback off
set define off
insert into open.ldci_encaintesap (COD_INTERFAZLDC, NUM_DOCUMENTOSAP, FECHDCTO, FECHCONT, GRLEDGER, REFERENC, TXTCABEC, CLASEDOC, SOCIEDAD, CURRENCY, COD_CENTROBENEF, COD_GRUPOCONCE, COD_CLASIFCONTA, IDENTIFICADOR)
values (5949, 2, to_date('31-08-2015', 'dd-mm-yyyy'), to_date('31-08-2015', 'dd-mm-yyyy'), 'TL', 'INGRESOS-5949', 'INGRESOS-5949', 'L1', 'GDCA', 'COP', null, null, 2, 29853);

prompt Done.
