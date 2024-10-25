declare
cursor cuPerifact1 is
select *
from open.perifact@OSFPL pr
where not exists(select null from open.perifact pcal where pr.pefacodi=pcal.pefacodi)
  and not exists(select null from open.perifact pcal where pr.pefacicl=pcal.pefacicl and pr.pefaano=pcal.pefaano and pr.pefames=pcal.pefames)
  and pefacicl= decode(&ciclo,-1, pr.pefacicl, &ciclo)
  ;

cursor cuPerifact2 is
select pr.*
from open.perifact@OSFPL pr, open.perifact pcal
where pcal.pefacodi=pr.pefacodi
  and pcal.pefacicl=pr.pefacicl
  and pcal.pefacicl= decode(&ciclo,-1,pr.pefacicl, &ciclo)
  and pcal.pefaano=pr.pefaano
  and pcal.pefames=pr.pefames
  and (pcal.pefafimo!=pr.pefafimo or
       pcal.pefaffmo!=pr.pefaffmo);
       
  cursor cuperifact3 is
  select *
  from perifact p
  where p.pefaactu='S'
   and (sysdate<p.pefafimo or  sysdate>p.pefaffmo)
   and pefacicl= decode(&ciclo,-1, pefacicl, &ciclo);       
   
   
   
   -----consumo
   cursor cuConsumo is
   select prod.*
from pericose pcalid, open.pericose@OSFPL prod
where pcalid.pecscico= decode(&ciclo,-1, pcalid.pecscico, &ciclo)
 and prod.pecscons=pcalid.pecscons
 and pcalid.pecscico=prod.pecscico
 and ((pcalid.pecsfeci!=prod.pecsfeci or
      pcalid.pecsfecf!=prod.pecsfecf) or
      (pcalid.pecsfeai!=prod.pecsfeai or
       pcalid.pecsfeaf!=prod.pecsfeaf)
      );
      
 cursor cuconsumo2 is
  select prod.*
from  open.pericose@OSFPL prod
where pecscico= decode(&ciclo,-1, pecscico, &ciclo)
 and not exists(select null from pericose pcalid where prod.pecscons = pcalid.pecscons);

begin
  execute immediate 'alter trigger TRGUPPERIFACT disable';
  execute immediate 'alter trigger TRGINSPERIFACT disable';
  execute immediate 'alter trigger TRGBIURPERICOSE disable';
  for reg in cuPerifact2 loop
    begin
      update perifact
         set pefafimo=reg.pefafimo,
              pefaffmo=reg.pefaffmo
         where pefacodi=reg.pefacodi;
         commit;
    exception
      when others then
        rollback;
        dbms_output.put_line(sqlerrm);
    end;
              
  end loop;
  for reg in cuPerifact1 loop
     begin
     insert into perifact values(reg.PEFACODI,reg.PEFAANO,reg.PEFAMES,reg.PEFASACA,reg.PEFAFIMO,reg.PEFAFFMO,reg.PEFAFECO,reg.PEFAFEPA,reg.PEFAFFPA,reg.PEFAFEGE,reg.PEFAOBSE,reg.PEFACICL,reg.PEFADESC,
                                 reg.PEFAFCCO,reg.PEFAFGCI,reg.PEFAACTU,reg.PEFAFEEM);
     commit;
     exception
       when others then
         rollback;
        dbms_output.put_line(sqlerrm);
     end;
  end loop;
  
    for reg in cuperifact3 loop
     /* update perifact
         set pefaactu='N'
       where pefacodi=reg.pefacodi;
       update perifact
          set pefaactu='S'
        where pefacicl=reg.pefacicl
          and pefafimo<=sysdate
          and pefaffmo>=sysdate
          and rownum=1;*/
	   update perifact
          set pefaactu='S'
        where pefacicl=reg.pefacicl
          and pefafimo<=sysdate
          and pefaffmo>=sysdate
          and rownum=1;
          if sql%rowcount > 0 then
             update perifact
               set pefaactu='N'
             where pefacodi=reg.pefacodi;
          end if;	  
		  
  end loop;
  
 ----------consumo
 dbms_output.put_line('Consumo');
 for reg in cuConsumo loop
     begin
       update pericose 
          set PECSFECI=Reg.PECSFECI,
              pecsfecf= reg.pecsfecf,
              pecsfeai =reg.pecsfeai,
              pecsfeaf = reg.pecsfeaf 
      where pecscons =reg.pecscons;
      commit;
     exception
       when others then
         rollback;
         dbms_output.put_line('Error consumo1');
         dbms_output.put_line(sqlerrm);
     end;
 end loop;
  for reg in cuConsumo2 loop
     begin
       insert into pericose values(reg.PECSCONS,reg.PECSFECI,reg.PECSFECF,/*reg.PECSPROC*/'N',reg.PECSUSER,reg.PECSTERM,reg.PECSPROG,reg.PECSCICO,/*reg.PECSFLAV*/'N',reg.PECSFEAI,reg.PECSFEAF);
      commit;
     exception
       when others then
         rollback;
         dbms_output.put_line('Error consumo2');
         dbms_output.put_line(sqlerrm);
     end;
 end loop;
  
execute immediate 'alter trigger TRGUPPERIFACT enable';  
  execute immediate 'alter trigger TRGBIURPERICOSE enable';
    execute immediate 'alter trigger TRGINSPERIFACT enable';
exception
    when others then
      rollback;
      execute immediate 'alter trigger TRGUPPERIFACT enable';
  execute immediate 'alter trigger TRGBIURPERICOSE enable';      
      execute immediate 'alter trigger TRGINSPERIFACT enable';
end;
