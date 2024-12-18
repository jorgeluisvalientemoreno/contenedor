create or replace procedure DEPURE_LDC_ORDER is
  osbMsgResult varchar2(500);

  cursor curldcorder is
	select le.*,le.rowid row_id
	  from OPEN.LDC_ORDER le
	  where le.ASIGNADO = 'S';
  rgsgLogErr curldcorder%rowtype;

  nuCont     number;
  stMsgErr   varchar2(2000);

  
  Begin
  --Inicializa las variables
  nuCont:=0;
	--Borrado de la tabla OPEN.DEPURE_LDC_ORDER
  for rgsgLogErr in curldcorder loop
	  delete
	  from OPEN.LDC_ORDER
	  where rowid=rgsgLogErr.row_id;
	  nuCont:=nuCont+1;
	  if mod(nuCont,100)=0 then
		commit;
		nuCont:=0;
	  end if;
  end loop;
  commit;
  nuCont:=0;
	exception
	when others then
	  stMsgErr := sqlerrm;
	  osbMsgResult := 'Error en Depuración: '||stMsgErr;
	  DBMS_OUTPUT.put_line(osbMsgResult);
	  return;
End DEPURE_LDC_ORDER;
/