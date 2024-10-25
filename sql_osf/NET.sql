select se.*, rowid from open.sa_executable se where se.name like upper('%ldfactdup%'); 
select * from open.ge_entity g where g.name_ like 'GI_%'; 
select * from open.GI_ASSEMBLY ga where ga.assembly_id = 79;-- upper(ga.assembly) like upper('%TTPAT%'); 
select * from open.GI_CLASS gc where upper(gc.type_name) like upper('%ldfactdup%'); 

--Consultar .NET en OSF
select se.*, rowid from open.sa_executable se where se.executable_type_id = 17 and se.name = 'CCQUO';
select * from open.GI_CLASS gc where upper(gc.type_name) like upper('%ldfactdup%'); 
select * from open.ge_entity g where g.name_ like 'GI_%'; 
select * from open.GI_ASSEMBLY ga where upper(ga.assembly) like upper('%ldfactdup%'); 
select * from open.GI_CLASS gc where upper(gc.type_name) like upper('%ldfactdup%'); 


