declare 

  producto number(10)  ;
  promedio number(10)  ;
  desv number(10)  ;
  consumo_desv number(10);
  periodo_fact number(6);
  lectura_ant number(10);
  calificacion varchar(25);
  lectura_act number(10);
  porcentaje number(10)  ;
  
  cursor consumo_actual   is 
  select  ( promedio*(1 + desv/100))  from dual ;
  
  cursor  max_perifact   is 
  select   max(l2.leempefa) periodo_fact  
  from open.lectelme l2 
  where l2.leemsesu = producto ;
  
    cursor consumo_anterior  is
  (select lectelme.leemleto lectura_ant
   from open.lectelme
   where   leemsesu = producto
   and leempefa < periodo_fact
                   and leemfele = (select max(l3.leemfele)
                                   from lectelme l3
                                    where lectelme.leemsesu = l3.leemsesu
                                    and  leempefa < periodo_fact));

  cursor  calificacion_est is
  (select calivaco.cavccodi ||' : '|| initcap(calivaco.cavcdesc) as calificacion 
  from open.caravaco
  inner join open.racavaco on racavaco.rcvccrvc = crvccodi
  inner join open.calivaco on calivaco.cavccodi = racavaco.rcvccavc 
  where caravaco.crvccate = (select category_id  
                           from open.pr_product
                           where product_id = producto)
   and caravaco.crvcsuca = (select subcategory_id   
                         from open.pr_product
                         where product_id = producto)
   and  promedio  between caravaco.crvcraci and caravaco.crvcracf
  and round(( consumo_desv - promedio) /  promedio * 100)  between racavaco.rcvcrain and racavaco.rcvcrafi  );
 
  cursor consumo_final  is
   select (lectura_ant + consumo_desv )  , round(( consumo_desv - promedio) / promedio * 100)  
   from dual; 
 

begin 
  
  producto := 50734808  ;
  promedio :=  108.667  ;
  desv := 81  ;
     
  open consumo_actual ; 
  fetch consumo_actual into consumo_desv ; 
  dbms_output.put_line ('Consumo desviado: '|| consumo_desv);
  close consumo_actual ;

  open max_perifact ; 
  fetch max_perifact into   periodo_fact ; 
  dbms_output.put_line ('Max fecha fact: '||   periodo_fact);
  close max_perifact ;
  
  open consumo_anterior  ; 
  fetch consumo_anterior  into  lectura_ant ; 
  dbms_output.put_line ('Lect anterior : '|| lectura_ant);
  close consumo_anterior  ;
  
  open calificacion_est  ; 
  fetch calificacion_est  into  calificacion ; 
  dbms_output.put_line ('Calificacion de consumo '|| calificacion);
  close calificacion_est  ;
  
  open consumo_final  ; 
  fetch consumo_final  into  lectura_ant ,   porcentaje  ; 
  dbms_output.put_line ('Lectura a ingresar :'|| lectura_ant  );
   dbms_output.put_line ('Porcentaje de desviacion :'||   porcentaje  );
  close consumo_final  ;
  
  end ; 
