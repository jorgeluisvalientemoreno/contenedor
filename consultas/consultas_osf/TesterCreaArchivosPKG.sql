declare
    nuerror ge_error_log.message_id%TYPE;
    sberror ge_error_log.description%TYPE; 
        flarch pkg_gestionarchivos.styArchivo;
    sbrutaarchiv varchar2(2000) := '/smartfiles/SCR/cartera';
    sbnombrearinco  varchar2(200) :=  'PruebaJG.txt';

begin
    ut_trace.Init;
    ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
    ut_trace.SetLevel(99);
    --execute immediate 'alter session set sql_trace true';
		--execute immediate 'alter session set timed_statistics=true';
	--PKGENERALSERVICES.SETTRACEDATAON('DP',USER_OBJECTS.OBJECT_NAME);
	PKGENERALSERVICES.SETTRACEDATAON;
    ut_trace.Trace('INICIO');
    
    
    

    flarch := pkg_gestionarchivos.ftabrirarchivo_smf(sbrutaarchiv, sbnombrearinco, 'W');
    pkg_gestionarchivos.prcEscribirLinea_SMF(flarch,'Prueba escritura');
    pkg_gestionarchivos.prcCerrarArchivo_SMF(flarch);
    
    
    dbms_output.put_line('Finalizo sin error');
    dbms_output.put_line(concat('Mensaje ',sberror));
    
    --execute immediate 'alter session set sql_trace false';
    PKGENERALSERVICES.SETTRACEDATAOFF;

exception
    when pkg_error.CONTROLLED_ERROR then
        pkg_error.geterror(nuerror,sberror);
        dbms_output.put_line(concat('Error controlado: ',sberror));
        --execute immediate 'alter session set sql_trace false';
        PKGENERALSERVICES.SETTRACEDATAOFF;
    when others then
        pkg_error.seterror;
        pkg_error.geterror(nuerror,sberror);
        dbms_output.put_line(concat('Error others: ',sberror));
        --execute immediate 'alter session set sql_trace false';
        PKGENERALSERVICES.SETTRACEDATAOFF;
end;
 
declare
    flarch pkg_gestionarchivos.styArchivo;
    sbrutaarchiv varchar2(2000) := '/smartfiles/SCR/cartera';
    sbnombrearinco  varchar2(200) :=  'PruebaJG.txt';
begin
    flarch := pkg_gestionarchivos.ftabrirarchivo_smf(sbrutaarchiv, sbnombrearinco, 'W');
    pkg_gestionarchivos.prcEscribirLinea_SMF(flarch,'Prueba escritura');
    pkg_gestionarchivos.prcCerrarArchivo_SMF(flarch);
end;