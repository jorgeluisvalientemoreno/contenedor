select ccbgdpto, (select description from OPEN.GE_GEOGRA_LOCATION where GEOGRAP_LOCATION_ID = ccbgdpto) departamento,
       ccbgloca, (select description from OPEN.GE_GEOGRA_LOCATION where GEOGRAP_LOCATION_ID = ccbgloca) localidad,
       ccbgtitr, (select description from OPEN.OR_TASK_TYPE where task_type_id = ccbgtitr) tipotrab,
       (select t.clcocodi||'-'||t.clcodesc from open.ic_clascont t, open.ic_clascott o
         where t.clcocodi = o.clctclco and o.clcttitr = ccbgtitr) Clas_Contable,
       (select cuencosto||' - '||cuengasto from open.Ldci_cugacoclasi c
         where c.cuenclasifi = (select t.clcocodi from open.ic_clascont t, open.ic_clascott o
                                  where t.clcocodi = o.clctclco and o.clcttitr = ccbgtitr)) Costo_Gasto,
       ccbgceco, (select CECODESC from OPEN.LDCI_CENTROCOSTO where CECOCODI = ccbgceco) ceco,
       ccbgorin, (select DESC_ORDEINTERNA from OPEN.LDCI_ORDENINTERNA where CODI_ORDEINTERNA = ccbgorin) OI
  from OPEN.LDCI_CECOUBIGETRA 
