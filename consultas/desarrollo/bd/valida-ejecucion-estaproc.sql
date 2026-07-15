SELECT *
FROM gv$session, estaproc
WHERE UPPER (PROCESO) LIKE '%' || UPPER ('LDPSF_VEEX_') || '%'
AND SESION = AUDSID;

--se usa aca "pkg_estaproc.fblValidaEjecucionProc