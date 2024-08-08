DECLARE
  gsbChainJobsPBMAFA VARCHAR2(30) := 'CADENA_JOBS_GOPCVNEL';
BEGIN
  dbms_output.put_line('Inicia Borrado cadena de Jobs ' ||
                       gsbChainJobsPBMAFA);

  pkg_scheduler.pDropSchedChain(gsbChainJobsPBMAFA);

  COMMIT;

  dbms_output.put_line('Borrada cadena de Jobs ' || gsbChainJobsPBMAFA);

END;
