select sesususc,
       sesunuse,
       sesusafa  
from open.servsusc s
where sesususc in (select contpadre  
                   from open.ldc_contanve
                   where contanul  in (67130547,67130568,67130577,67130598,67130610))
