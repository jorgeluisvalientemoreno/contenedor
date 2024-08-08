select coseconc, 
       coseserv, 
       cosefufa, 
       coseorge, 
       coseacti, 
       coseflim, 
       coseclco, 
       coseregl, 
       coseniro, 
       cosefeli
from open.concserv
where coseserv= 7014 
and coseconc in (137,287);

--Deben estar activos los conceptos para que se generen coseacti ='S'