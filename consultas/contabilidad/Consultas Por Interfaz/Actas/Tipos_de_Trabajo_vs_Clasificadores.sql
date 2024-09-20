select t.clctclco, (select ct.clcodesc from open.ic_clascont ct where ct.clcocodi = t.clctclco) desc_clasificador,
       t.clcttitr, (select tp.description from open.or_task_type tp where tp.task_type_id = t.clcttitr) desc_tipo_trabajo,
       c.cuencosto, c.cuengasto
  from open.ic_clascott t,  open.ldci_cugacoclasi c
 where t.clctclco = c.cuenclasifi
