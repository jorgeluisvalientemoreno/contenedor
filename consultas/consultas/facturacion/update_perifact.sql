declare 
  cursor cuperifact is
  select *
  from perifact p
  where p.pefaactu='S'
   and (sysdate<p.pefafimo or  sysdate>p.pefaffmo);
begin
  for reg in cuperifact loop
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
end;
