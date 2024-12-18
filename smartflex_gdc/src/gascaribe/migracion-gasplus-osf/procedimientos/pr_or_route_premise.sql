CREATE OR REPLACE PROCEDURE PR_OR_ROUTE_PREMISE (INUBASEDATO number) 
AS


procedure ROUTE_PREMISE_SURTIGAS
as
cursor cuservicio
is
select b.estate_number
from open.servsusc,open.pr_product a, open.ab_address b
where sesucicl=1021
and product_id=sesunuse
and a.address_id=b.address_id;


cursor cuservicio2
is
select b.estate_number
from open.servsusc,open.pr_product a, open.ab_address b
where sesucicl=2021
and product_id=sesunuse
and a.address_id=b.address_id;

cursor cuservicio3
is
select b.estate_number
from open.servsusc,open.pr_product a, open.ab_address b
where sesucicl=4021
and product_id=sesunuse
and a.address_id=b.address_id;


i number:=1;
NUERRORES number;
nuLogError number;

nuruta number;

begin

  PKLOG_MIGRACION.prInsLogMigra (4989,4989,1,'PR_OR_ROUT_PREMISE',0,0,'Inicia Proceso','INICIO',nuLogError);
    commit;
  
    
    select max(route_id)+1  into nuruta from or_route;
    insert into open.or_route 
    values(nuruta,'RUTA:'||chr(nuruta),NULL,'Y');-- 6691 6391

    for r in cuservicio
    loop
       insert into open.or_route_premise
       values(i,r.estate_number,nuruta,i);
       i:=i+1; 
    end loop;
    
    commit;
    select max(route_id)+1  into nuruta from or_route;
    insert into open.or_route 
    values(nuruta,'RUTA:'||chr(nuruta),NULL,'Y');--- 6691 6391

    for r in cuservicio2
    loop
        insert into open.or_route_premise
        values(i,r.estate_number,nuruta,i);
       i:=i+1; 
    end loop;
    
    commit;


    select max(route_id)+1  into nuruta from or_route;
    insert into open.or_route 
    values(nuruta,'RUTA:'||chr(nuruta),NULL,'Y');--- 6691 6391

    for r in cuservicio3
    loop
        insert into open.or_route_premise
        values(i,r.estate_number,nuruta,i);
       i:=i+1; 
    end loop;
    
    commit;
    PKLOG_MIGRACION.prInsLogMigra (4989,4989,3,'PR_OR_ROUT_PREMISE',0,0,'Inicia Proceso','INICIO',nuLogError);
    commit;
 
   
EXCEPTION
     WHEN OTHERS THEN
        BEGIN

           NUERRORES := NUERRORES + 1;
            PKLOG_MIGRACION.prInsLogMigra ( 4989,4989,2,null,0,0,'Código : '||i||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);

        END;


END;

procedure ROUTE_PREMISE_EFIGAS
as
cursor cuservicio
is
select b.estate_number
from open.servsusc,open.pr_product a, open.ab_address b
where sesucicl=1791
and product_id=sesunuse
and a.address_id=b.address_id;


cursor cuservicio2
is
select b.estate_number
from open.servsusc,open.pr_product a, open.ab_address b
where sesucicl=6691
and product_id=sesunuse
and a.address_id=b.address_id;

cursor cuservicio3
is
select b.estate_number
from open.servsusc,open.pr_product a, open.ab_address b
where sesucicl=6391
and product_id=sesunuse
and a.address_id=b.address_id;

cursor cuservicio4
is
select b.estate_number, nvl(d.consecutive,1) consecutive
from open.servsusc,open.pr_product a, open.ab_address b,open.ab_premise d
where sesucicl=1712
and product_id=sesunuse
and d.premise_id=b.estate_number
and a.address_id=b.address_id;

cursor cuservicio5
is
select b.estate_number, nvl(d.consecutive,1) consecutive
from open.servsusc,open.pr_product a, open.ab_address b,open.ab_premise d
where sesucicl=1713
and product_id=sesunuse
and d.premise_id=b.estate_number
and a.address_id=b.address_id;


nuruta number;
i number:=1;
NUERRORES number;
nuLogError number;

begin

  PKLOG_MIGRACION.prInsLogMigra (4989,4989,1,'PR_OR_ROUT_PREMISE',0,0,'Inicia Proceso','INICIO',nuLogError);
    commit;
  
    select max(route_id)+1  into nuruta from or_route;
    insert into open.or_route 
    values(nuruta,'RUTA:'||chr(nuruta),NULL,'Y');--- 6691 6391

    for r in cuservicio
    loop
       insert into open.or_route_premise
       values(i,r.estate_number,nuruta,i);
       i:=i+1; 
    end loop;
    
    commit;
    select max(route_id)+1  into nuruta from or_route;
    insert into open.or_route 
    values(nuruta,'RUTA:'||chr(nuruta),NULL,'Y');--- 6691 6391

    for r in cuservicio2
    loop
        insert into open.or_route_premise
        values(i,r.estate_number,nuruta,i);
       i:=i+1; 
    end loop;
    
    commit;


    select max(route_id)+1  into nuruta from or_route;
    insert into open.or_route 
    values(nuruta,'RUTA:'||chr(nuruta),NULL,'Y');--- 6691 6391

    for r in cuservicio3
    loop
        insert into open.or_route_premise
        values(i,r.estate_number,nuruta,i);
       i:=i+1; 
    end loop;
    
    commit;
       
    select max(route_id)+1  into nuruta from or_route;
    insert into open.or_route 
    values(nuruta,'RUTA:'||chr(nuruta),NULL,'Y');--- 6691 6391

    for r in cuservicio4
    loop
        insert into open.or_route_premise
        values(i,r.estate_number,nuruta,r.consecutive);
       i:=i+1; 
    end loop;
    
    commit;
    select max(route_id)+1  into nuruta from or_route;
    insert into open.or_route 
    values(nuruta,'RUTA:'||chr(nuruta),NULL,'Y');--- 6691 6391

    for r in cuservicio5
    loop
        insert into open.or_route_premise
        values(i,r.estate_number,nuruta,r.consecutive);
       i:=i+1; 
    end loop;
    
    commit;
    PKLOG_MIGRACION.prInsLogMigra (4989,4989,3,'PR_OR_ROUT_PREMISE',0,0,'Inicia Proceso','INICIO',nuLogError);
    commit;
 
   
EXCEPTION
     WHEN OTHERS THEN
        BEGIN

           NUERRORES := NUERRORES + 1;
            PKLOG_MIGRACION.prInsLogMigra ( 4989,4989,2,null,0,0,'Código : '||i||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);

        END;


END;

procedure ROUTE_PREMISE_GASCARIBE
as

cursor curutas
is
select distinct (to_number(to_char(ciclo)||'0000')) ruta from migra.ruta;


cursor cuservicio
is
select decode(basedato,3,a.product_id+500000,a.product_id)producto, a.estate_number predio ,to_number(to_char(ciclo)||'0000') ruta, consecutivo
from migra.ruta a ,pr_product p, ab_address a
where decode(basedato,3,a.product_id+500000,a.product_id)=p.product_id
and p.address_id=a.address_id

;

i number:=1;
NUERRORES number;
nuLogError number;

begin

  PKLOG_MIGRACION.prInsLogMigra (4989,4989,1,'PR_OR_ROUT_PREMISE',0,0,'Inicia Proceso','INICIO',nuLogError);
    commit;
  
    for r in curutas
    loop
    insert into open.or_route 
    values(r.ruta,'RUTA:'||chr(r.ruta),NULL,'Y');-- 6691 6391
    end loop;
    
    i:=1;
    for r in cuservicio
    loop
       
       insert into open.or_route_premise
       values( i,r.predio,r.ruta,r.consecutivo);
       i:=i+1; 
    end loop;
    
    commit;
    PKLOG_MIGRACION.prInsLogMigra (4989,4989,3,'PR_OR_ROUT_PREMISE',0,0,'Inicia Proceso','INICIO',nuLogError);
    commit;
 
   
EXCEPTION
     WHEN OTHERS THEN
        BEGIN            
           NUERRORES := NUERRORES + 1;
            PKLOG_MIGRACION.prInsLogMigra ( 4989,4989,2,null,0,0,'Código : '||i||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);

        END;


END;

begin

    if inubasedato=5 then
        ROUTE_PREMISE_EFIGAS;
    end if;
   
    if inubasedato=1 then
        ROUTE_PREMISE_GASCARIBE;
    end if; 
   

    if inubasedato=4 then
        ROUTE_PREMISE_SURTIGAS;
    end if;  
end; 
/
