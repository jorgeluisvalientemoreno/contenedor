declare
    nuCantReg       NUMBER := 0;
    rfcArch         SYS_REFCURSOR; -- Obtiene nombre archivo con la ruta
    varchnomb       VARCHAR2(2000); -- contiene el nombre del archivo al momento de extraer la ruta
    nulongRuta      NUMBER; -- longitud de cadena para la ruta
    nuPosDirec      NUMBER; -- cantidad de caracteres hasta el ultimo directorio
    ofiles          VARCHAR2(1024); -- variable para el majeno de archivos
    sbruta          varchar2(2000);
    nuperiodo       number;
    sbfiltro        varchar2(200);

begin
    sbruta := '/smartfiles/Facturacion/Carvajal';
    nuperiodo := 115715;
    sbfiltro := 'FIDF_'||nuperiodo||'%';

    dbms_output.put_line('Listado archivos ruta '||sbruta||chr(13)||'Filtro '||sbfiltro);
    dbms_output.put_line('============================================');
    SYS.DBMS_BACKUP_RESTORE.searchFiles(sbruta, ofiles);
    OPEN rfcArch FOR
    SELECT FNAME_KRBMSFT FROM sys.ldc_files order by FNAME_KRBMSFT;

    LOOP
          FETCH rfcArch
            INTO varchnomb;
          EXIT WHEN rfcArch%NOTFOUND;

          nuCantReg := nuCantReg + 1;

          -- Obtiene la cantidad de caracteres de toda la cadena
          nulongRuta := length(varchnomb);

          -- cantidad de caracteres hasta el ultimo directorio
          nuPosDirec := Length(RTRIM(varchnomb,
                                     'ABCDEFGHIJKLMNOPQRSTUXYZabcdefghijklmnopqrstxyz._0123456789'));

          -- Extrae el nombre del archivo
          varchnomb := SubStr(varchnomb, nuPosDirec + 1);

          if varchnomb like sbfiltro then
            dbms_output.put_line(varchnomb);
            --utl_file.fremove(sbruta,varchnomb);
          end if;
    END LOOP;
end;
