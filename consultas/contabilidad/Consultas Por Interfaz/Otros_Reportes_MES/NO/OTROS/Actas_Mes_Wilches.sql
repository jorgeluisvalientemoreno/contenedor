select txtposcn Acta, 
       (select g.extern_pay_date from open.ge_acta g where g.id_acta = to_number(substr(txtposcn, 6, 8))) Fecha,
       clavref1 Nit, clavref3 Nombre, 
       tipotrab Tipo_Tr, (select p.description from open.or_task_type p where p.task_type_id = tipotrab) Des_TIPOTRAB,
       t.clctclco Clasc, c.clcodesc Descripcion, 
       clavcont Clave, clasecta Cuenta, sum(round(impomtrx)) Total
  from open.ldci_incoliqu, open.ic_clascott t, open.ic_clascont c--, open.ldci_actacont
 where iclinudo in (select codocont from OPEN.LDCI_ACTACONT t, open.ge_acta a 
                     where a.extern_invoice_num is not null
                       and a.extern_pay_date >= '09-02-2015'
                       and a.extern_pay_date <  '01-06-2015'
                       and a.id_acta = t.idacta
                       and t.actcontabiliza = 'S'
                       /*and a.id_acta = 8979*/)
   and tipotrab = t.clcttitr and t.clctclco = c.clcocodi 
Group by txtposcn, clavref1, clavref3, tipotrab, t.clctclco, c.clcodesc, clavcont, clasecta
