select *
  from dba_objects a
 where a.OWNER = 'ORM'
   and a.OBJECT_TYPE = 'TABLE'
   and a.OBJECT_NAME like 'OPT%';
select *
  from dba_tables b
 where b.TABLE_NAME in (select a.OBJECT_NAME
                          from dba_objects a
                         where a.OWNER = 'ORM'
                           and a.OBJECT_NAME like 'OPT%'
                           and a.OBJECT_TYPE = 'TABLE');
/*
1943,Valida_Revisoria_Facturacion_x_Concepto,False
1941,Log InfoRevFiscal,False
1942,Reporte de ordenes de trabajo que estan en acta,False
1450,Ordenes por Tipo de Trabajo y Fecha Creacion,False
1950,Ordenes de trabajo sin liquidar en acta,False
1272,Ordenes de Tipos de Trabajo de Gastos,False
452,LDRGOPC - Ordenes de persecucion ,False
1596,LDRREPRPRRP,False
1597,LDRRELOGPRCS,False
1290,CONSULTA FLUJOS DETENIDOS,False
942,LDCOGREPI,False
176,Reporte de validacion de ordenes pendientes por liquidar,False
*/
