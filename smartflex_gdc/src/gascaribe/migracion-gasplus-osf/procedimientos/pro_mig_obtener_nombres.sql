CREATE OR REPLACE PROCEDURE        "PRO_MIG_OBTENER_NOMBRES" (vpersnom  in varchar2,
						  vnombres   OUT varchar2,
						  vprimerap  OUT varchar2,
						  vsegundoap out varchar2)

/*
PROCEDIMIENTO : PRO_MIG_OBTENER_NOMBRES
AUTOR         : Xiomara Castillo Feria/OLSoftware
FECHA         : 01-12-2012
DESCRIPCION   : obtener el nombre en nombres, apellido1 y apellido2

Parametros de Entrada

Parametros de Salida

Historia de Modificaciones
Autor   Fecha   Descripcion
************************************************************************/
is

	--variables de procesamiento de nombre
	pe1 			number;
	pe2 			number;
	pe3 			number;
	tamano 		number;
	palabra1 	varchar2(100);
	palabra2 	varchar2(100);
	palabra3 	varchar2(100);
	palabra4 	varchar2(100);
	nc          varchar2(200);
	nume    	   number;
begin
	nc := replace(replace(replace(replace(replace(replace(replace(replace(upper(ltrim(vpersnom)),' DE LA ',' DEchr(20)LAchr(20)'),' DE LAS ',' DEchr(20)LASchr(20)'),' DE LOS ',' DEchr(20)LOSchr(20)'),' DE ',' DEchr(20)'),' DEL ',' DELchr(20)'),'  ',' '),'  ',' '),'  ',' ');
	tamano := length(nc);
	nume   := length(nc) - length(replace( nc,' '));
	if nume = 0 then
    vnombres   := replace(nc,'chr(20)',' ');
    vprimerap  := NULL;
    vsegundoap := NULL;
	elsif nume = 1 then
    pe1 		 := instr(nc,' ',1,1);
    palabra1 := substr(nc,1,pe1-1);
    palabra2 := substr(nc,pe1+1,tamano-pe1);
    vnombres := replace(palabra1,'chr(20)',' ');
    vprimerap := replace(palabra2,'chr(20)',' ');
    vsegundoap := NULL;
	elsif nume = 2 then
    pe1 	  := instr(nc,' ',1,1);
    pe2 	  := instr(nc,' ',1,2);
    palabra1 := substr(nc,1,pe1-1);
    palabra2 := substr(nc,pe1+1,pe2-1-pe1);
    palabra3 := substr(nc,pe2+1,tamano-pe2);
    --vnombres := replace(palabra1,'chr(20)',' ');
    --vprimerap := replace(palabra2,'chr(20)',' ');
    --vsegundoap := replace(palabra3,'chr(20)',' ');

    vnombres := replace(palabra1,'chr(20)',' ')||' '||replace(palabra2,'chr(20)',' ');
    vprimerap := replace(palabra3,'chr(20)',' ');
    vsegundoap := NULL;
	elsif nume > 2 then
    pe1 	  := instr(nc,' ',1,1);
    pe2 	  := instr(nc,' ',1,2);
    pe3 	  := instr(nc,' ',1,3);
    palabra1 := substr(nc,1,pe1-1);
    palabra2 := substr(nc,pe1+1,pe2-1-pe1);
    palabra3 := substr(nc,pe2+1,pe3-1-pe2);
    palabra4 := substr(nc,pe3+1,tamano-pe3);
    vnombres := replace(palabra1,'chr(20)',' ')||' '||replace(palabra2,'chr(20)',' ');
    --vprimerap := replace(palabra3,'chr(20)',' ');
    --vsegundoap := replace(palabra4,'chr(20)',' ');
    vprimerap:=replace(palabra3,'chr(20)',' ')||' '||replace(palabra4,'chr(20)',' ');
    vsegundoap := NULL;
	end if;
  --dbms_output.put_line('nombres: '||vnombres);
  --dbms_output.put_line('primer apellido: '||vprimerap);
  --dbms_output.put_line('segund apellido: '||vsegundoap);

end pro_mig_obtener_nombres;
/
