/*declare
 nuseq number:=0;
 nuproxhueco number:=248543600;
 numax number:=248583101-5000;
 i number:=0;
 j number:=1000000;
begin
  while nuseq< numax loop
    
    SELECT S.LAST_NUMBER  
    into nuseq
    FROM DBA_sEQUENCES S 
    
    WHERE S.SEQUENCE_NAME='SEQ_GE_WORKFLOW_INSTANCE';
    if nuseq<numax then
      dbms_lock.sleep(5);
    end if;
  end loop;
  
  while i<=j loop
    nuseq :=OPEN.SEQ_GE_WORKFLOW_INSTANCE.NEXTVAL;
    IF nuseq < nuproxhueco THEN
      null;
    else 
      "OPEN".ldc_sendemail('dsaltarin@gascaribe.com','Avanzo secuencia', null);
      "OPEN".ldc_sendemail('diana.saltarin@gascaribe.com','Avanzo secuencia', null);
      i:=j;
      exit;
    END IF;
  end loop;
  
end;*/
declare
 nuseq number:=0;
 nuproxhueco number;
 numax number:=null;
 i number:=0;
 j number:=1000000;
 nuRangos number;

 I2 NUMBER:=0;
 J2 NUMBER:=100;

 cursor cuHuecos IS
 select i.valor_inicial, i.valor_final, rowid
   from open.ldc_huecos_disp_instancia i
  where i.usado ='N'
  order by 1;

  rwHuegos cuHuecos%rowtype;
  NOMBRE_BD varchar2(4000);
begin



  WHILE I2 < J2 LOOP
    if numax is null THEN
    --se busca el maximo del rango
      begin
    select max(i.valor_final)
      into numax
    from open.ldc_huecos_disp_instancia  i
    where i.usado='S';
    EXCEPTION
     when others THEN
      numax := null;
    end;
    end if;
    ---busco proximo hueco disponible
    if numax  is not null then
      open cuHuecos;
      fetch cuHuecos into rwHuegos;
      if cuHuecos%found THEN
      nuproxhueco := rwHuegos.valor_inicial;
      while nuseq< numax loop
        SELECT S.LAST_NUMBER
        into nuseq
        FROM all_sEQUENCES S
        WHERE S.SEQUENCE_NAME='SEQ_GE_WORKFLOW_INSTANCE';
        if nuseq<numax then
          dbms_lock.sleep(5);
        end if;
      end loop;

      select count(1)
        into nuRangos
        from open.ldc_huecos_disp_instancia  i
        where i.usado='N'
        and rowid!=rwHuegos.rowid;

      while i<=j loop
        nuseq :=OPEN.SEQ_GE_WORKFLOW_INSTANCE.NEXTVAL;
        IF nuseq < nuproxhueco THEN
          null;
        else
          "OPEN".ldc_sendemail('dsaltarin@gascaribe.com',NOMBRE_BD||'Avanzo secuencia', 'Quedan '||nuRangos||' huecos disponibles.'||nuproxhueco||'-'||rwHuegos.valor_final);
          "OPEN". ldc_sendemail('jdonado@gascaribe.com',NOMBRE_BD||'Avanzo secuencia', 'Quedan '||nuRangos||' huecos disponibles.'||nuproxhueco||'-'||rwHuegos.valor_final);
          "OPEN".ldc_sendemail('jvaliente@horbath.com',NOMBRE_BD||'Avanzo secuencia', 'Quedan '||nuRangos||' huecos disponibles.'||nuproxhueco||'-'||rwHuegos.valor_final);
				  i:=j;
				  exit;
				END IF;
			end loop;

			numax := rwHuegos.valor_final - 5000;
			update open.ldc_huecos_disp_instancia set usado = 'S' where rowid = rwHuegos.rowid;
			commit;
		end if;--if numax  is not null then
	  ELSE
		I2 := I2+1;
		numax := null;
		"OPEN".ldc_sendemail('dsaltarin@gascaribe.com',NOMBRE_BD||'Secuencia', 'No se encontraron huecos : '||i2);
	  end if;
	  close cuHuecos;
  END LOOP;

end;

