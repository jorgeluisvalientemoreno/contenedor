select d.* , sesuesco, sesuserv, sesuesfn , SESUCATE , sesuplfa , sesucicl 
from diferido d
inner join servsusc on difesusc = sesususc and difenuse=sesunuse
where difesape >0 
and difeprog='GCNED' and sesucate in (2,3) AND sesuplfa in (54,
52,
51,
50,
49,
48,
47,
46,
45,
43,
42,
41,
36,
35,
34,
31,
30,
22,
16,
8,
4
);

