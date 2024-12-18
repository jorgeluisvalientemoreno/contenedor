
  CREATE OR REPLACE PROCEDURE "OPEN"."ACTUAFEPACUE" (numinicial number, numfinal number) is
    nuErrorCode NUMBER;
    sbErrorMessage VARCHAR2(4000);

   cursor cu is
           select cucocodi,rowid
                  from cuencobr
                  where cuconuse>=numinicial and cuconuse<numfinal and
                        nvl(cucovaab,0)>0 and
                        cucofepa is null;
    van number;
    fpa date;
    nuLogError number;
BEGIN
	  PKLOG_MIGRACION.prInsLogMigra (1537,1537,1,'actuafepacue',0,0,'Inicia Proceso','INICIO',nuLogError);
    van:=0;
	--  for c in cu loop
	--  	  select max(cargfecr) into fpa from cargos where cargcuco=c.cucocodi and cargsign in ('PA','AS');
	--  	  UPDATE cuencobr set cucofepa=fpa where rowid=c.rowid;
	--  	  van:=van+1;
	--  	  if van=1000 then
	-- 	  	 commit;
	--  	  	 van:=0;
	--  	  end if;
	--  end loop;
	--  commit;
    update cuencobr set cucofepa=null where  CUCOFEPA<'1/1/1981' and nvl(cucovaab,0)=0 and cuconuse>=numinicial and cuconuse<numfinal ;
    commit;
    update cuencobr set cucofepa=cucofeve where CUCOFEPA<'1/1/1981' and nvl(cucovaab,0)<>0 and cuconuse>=numinicial and cuconuse<numfinal ;
    commit;
    update cuencobr set cucofepa=cucofeve where cucofepa>sysdate and cuconuse>=numinicial and cuconuse<numfinal ;
    commit;

    PKLOG_MIGRACION.prInsLogMigra (1537,1537,3,'actuafepacue',0,0,'Termina Proceso','FIN',nuLogError);

EXCEPTION
    when OTHERS then
        Errors.setError;
        Errors.getError(nuErrorCode, sbErrorMessage);
        dbms_output.put_line('ERROR OTHERS ');
        dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
        dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);
END;
/
