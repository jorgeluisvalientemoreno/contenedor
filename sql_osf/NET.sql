select se.*, rowid from open.sa_executable se where se.name like upper('%LDFACTDUP%'); 
select * from open.ge_entity g where g.name_ like 'GI_%'; 
select * from open.GI_ASSEMBLY ga where ga.assembly_id = 79;-- upper(ga.assembly) like upper('%TTPAT%'); 
select * from open.GI_CLASS gc where upper(gc.type_name) like upper('%LDFACTDUP%'); 

--Consultar .NET en OSF
select se.*, rowid from open.sa_executable se where se.executable_type_id = 17 and se.name = 'LDFACTDUP';
select * from open.GI_CLASS gc where upper(gc.type_name) like upper('%LDFACTDUP%'); 
select * from open.ge_entity g where g.name_ like 'GI_%'; 
select * from open.GI_ASSEMBLY ga where upper(ga.assembly) like upper('%LDFACTDUP%'); 
select * from open.GI_CLASS gc where upper(gc.type_name) like upper('%LDFACTDUP%'); 


