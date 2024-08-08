declare
    cursor cuDatos is
    select lower(OBJECT_NAME)||'.sql' nombre,OBJECT_TYPE , object_name, lower(d.owner) propietario
    from dba_objects d
    where OBJECT_NAME in ('TRGAILD_CUPON_CAUSAL')
    and object_type in ('PACKAGE','PROCEDURE','FUNCTION','TRIGGER')
     and owner='OPEN';

    cursor cuFuente(sbNombre varchar2, sbOwner varchar2) is
    select d.type,line, text, rownum
    from dba_source d
    where owner=upper(sbOwner)
     and name=upper(sbNombre)
     order by d.type,line;
    
    cursor cuPermisos(sbNombre varchar2, sbOwner varchar2) is
    select *
    from dba_tab_privs
    where owner = upper(sbOwner)
      and table_name=upper(sbNombre);
    

    sbRuta       VARCHAR2(4000) := '/smartfiles/Construcciones/';
    sbArchi      VARCHAR2(4000) := NULL;
    sbMessage    VARCHAR2(32767);
    INCO         UTL_FILE.FILE_TYPE;
    nuContador   NUMBER;
    sbGrants     VARCHAR2(32767);


    TYPE rcCaracEspe IS RECORD(
                CODIGO_ASCI VARCHAR2(50),
                CODIGO_UTF8 VARCHAR2(50),
                CODIGO_CHAR NUMBER
                 );


    TYPE tbCaracEspe IS TABLE OF rcCaracEspe INDEX BY binary_integer;
    tcCaraEspe tbCaracEspe;

    i number:=0;
    j number:=11;

    procedure prCrearArchivo is
    begin
      INCO := UTL_FILE.FOPEN(sbRuta, sbArchi, 'W', 32767);
    end;
    procedure prCerrarArchivo is
    begin
      UTL_FILE.FCLOSE(INCO);
    end;

  procedure prReemplazaCara(sbCadena in out varchar2) is
  begin
    i := 0;
    while i<=j loop
      sbCadena := replace(sbCadena,tcCaraEspe(i).CODIGO_ASCI,tcCaraEspe(i).CODIGO_UTF8);
      i:=i+1;
    end loop;
  end;

begin
    tcCaraEspe(0).CODIGO_ASCI := 'Á';
    tcCaraEspe(0).CODIGO_UTF8 := 'Ã';
    tcCaraEspe(0).CODIGO_CHAR :=193;

    tcCaraEspe(1).CODIGO_ASCI := 'á';
    tcCaraEspe(1).CODIGO_UTF8 := 'Ã¡';
    tcCaraEspe(1).CODIGO_CHAR :=225;

    tcCaraEspe(2).CODIGO_ASCI := 'É';
    tcCaraEspe(2).CODIGO_UTF8 := 'Ã‰¡';
    tcCaraEspe(2).CODIGO_CHAR :=201;

   tcCaraEspe(3).CODIGO_ASCI := 'é';
    tcCaraEspe(3).CODIGO_UTF8 := 'Ã©';
    tcCaraEspe(3).CODIGO_CHAR :=233;

    tcCaraEspe(4).CODIGO_ASCI := 'Í';
    tcCaraEspe(4).CODIGO_UTF8 := 'Ã';
    tcCaraEspe(4).CODIGO_CHAR :=205;

    tcCaraEspe(5).CODIGO_ASCI := 'í';
    tcCaraEspe(5).CODIGO_UTF8 := 'Ã­';
    tcCaraEspe(5).CODIGO_CHAR :=237;

    tcCaraEspe(6).CODIGO_ASCI := 'Ó';
    tcCaraEspe(6).CODIGO_UTF8 := 'Ã“';
    tcCaraEspe(6).CODIGO_CHAR :=211;

    tcCaraEspe(7).CODIGO_ASCI := 'ó';
    tcCaraEspe(7).CODIGO_UTF8 := 'Ã³';
    tcCaraEspe(7).CODIGO_CHAR :=243;

    tcCaraEspe(8).CODIGO_ASCI := 'Ú';
    tcCaraEspe(8).CODIGO_UTF8 := 'Ãš';
    tcCaraEspe(8).CODIGO_CHAR :=218;

    tcCaraEspe(9).CODIGO_ASCI := 'ú';
    tcCaraEspe(9).CODIGO_UTF8 := 'Ãº';
    tcCaraEspe(9).CODIGO_CHAR :=250;

    tcCaraEspe(10).CODIGO_ASCI := 'Ñ';
    tcCaraEspe(10).CODIGO_UTF8 := 'Ã‘';
    tcCaraEspe(10).CODIGO_CHAR :=209;

    tcCaraEspe(11).CODIGO_ASCI := 'ñ';
    tcCaraEspe(11).CODIGO_UTF8 := 'Ã±';
    tcCaraEspe(11).CODIGO_CHAR :=241;
    /*
    tcCaraEspe(12).CODIGO_ASCI := '¿';
    tcCaraEspe(12).CODIGO_UTF8 := 'Â¿';
    tcCaraEspe(12).CODIGO_CHAR :=191;*/


    for reg in cuDatos loop
        begin
             sbArchi :=reg.nombre;
             if reg.propietario !='open' then
               sbArchi := reg.propietario||'.'||sbArchi;
             end if;

             prCrearArchivo;
             nuContador := 0;
             for reg2 in cuFuente(reg.object_name, reg.propietario) loop
               if reg2.line = 1 and reg2.rownum!=1 then
                 UTL_FILE.PUT_LINE(INCO, '/', FALSE);
               end if;
               if reg2.line = 1 then
                  sbMessage := 'CREATE OR REPLACE '||reg2.text;
               else
                  sbMessage := reg2.text;
               end if;

               prReemplazaCara(sbMessage);
               UTL_FILE.PUT_LINE(INCO, replace(sbMessage,CHR(10),''));

             end loop; 
             UTL_FILE.PUT_LINE(INCO, '/', FALSE);
             --permisos
             sbGrants := null;
             for gr in cuPermisos(reg.object_name, reg.propietario) loop
                sbGrants := 'GRANT '||gr.privilege||' on '||gr.table_name||' to '||gr.grantee||';';
                UTL_FILE.PUT_LINE(INCO, sbGrants, FALSE);
             end loop;
             if sbGrants is not null then
                UTL_FILE.PUT_LINE(INCO, '/', FALSE);
             end if;
             prCerrarArchivo;
        exception
            when others then
                dbms_output.put_line(sbArchi||' '||sqlerrm);
        end;
    end loop;
end;
/