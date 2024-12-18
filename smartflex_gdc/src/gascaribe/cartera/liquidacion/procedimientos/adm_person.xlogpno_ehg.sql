create or replace procedure  ADM_PERSON.XLOGPNO_EHG
(
	t 			IN varchar2,
	inuSession	IN NUMBER DEFAULT NULL
) 
IS
/*****************************************************************
    Historial de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
	12/12/2022		CGONZALEZ			OSF-741: Se modifica para adicionar el campo SESSION_ID
  ******************************************************************/
PRAGMA autonomous_transaction;
BEGIN
	insert into logpno_ehg(A, FECHA, SESSION_ID) values (t,sysdate, inuSession);
	commit;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('XLOGPNO_EHG', 'ADM_PERSON');
END;
/