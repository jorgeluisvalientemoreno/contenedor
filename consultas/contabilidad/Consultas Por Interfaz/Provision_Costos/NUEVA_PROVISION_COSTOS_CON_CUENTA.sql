select l.celocebe, coprcuad, c.nombre_contratista, coprclco, t.clcodesc, coprtitr, description, coprsign, 
       sum(coprvalo) total, i.cuencosto Cuenta,
       (SELECT CC.CECOCODI||' - '||CC.CECODESC FROM OPEN.LDCI_CECOUBIGETRA CE, OPEN.LDCI_CENTROCOSTO CC
         WHERE CE.CCBGDPTO = coprdepa AND CE.CCBGLOCA = coprloca AND CE.CCBGTITR = coprtitr
           AND CC.CECOCODI = CE.CCBGCECO) CECO      
  from open.ldci_costprov, open.ge_contratista c, open.OR_TASK_TYPe, open.ldci_centbenelocal l,
       OPEN.IC_CLASCONT t, open.Ldci_cugacoclasi i
 where copranoc = 2015
   and coprmesc = 9
   and coprcuad = id_contratista
   and coprtitr = task_type_id
   and coprdepa = celodpto
   and coprloca = celoloca  and  coprclco = t.clcocodi and coprclco = i.cuenclasifi
group by l.celocebe, coprcuad, c.nombre_contratista, coprclco, t.clcodesc, coprtitr, description, coprsign, i.cuencosto,
         coprdepa, coprloca;

select cuencosto 
 from open.ic_clascott o, /*OPEN.IC_CLASCONT t,*/ open.Ldci_cugacoclasi i
where tipotrabajo = o.clcttitr 
  and i.cuenclasifi = clctclco 
 
