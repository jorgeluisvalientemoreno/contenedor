update  master_personalizaciones set COMENTARIO = 'MIGRADO ADM_PERSON'
where  NOMBRE in ('LDCI_PKSERVICIOSCHATBOT');

commit;
/