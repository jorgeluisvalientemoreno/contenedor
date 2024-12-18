update open.ldc_procedimiento_obj a
   set a.activo = 'N'
 where a.task_type_id in (12150,12152,12153)
   and a.causal_id = 9944
   and a.procedimiento = 'LDC_PKORDENES.PROINTERNACXC';
commit;
/