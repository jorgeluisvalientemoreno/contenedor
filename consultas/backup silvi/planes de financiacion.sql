SELECT P.* 
FROM PLANDIFE P
where  /*pldifefi > SYSDATE  and */pldipoin is not null 
and not exists (select null
               from CODEPLFI 
               where CDPFPLDI = PLDICODI);
               
select * from mecadife
