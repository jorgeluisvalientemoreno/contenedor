Select o.*,t.* --a.Aplica
  From open.Ldc_Versionentrega t,
       open.Ldc_Versionempresa e,
       open.Ldc_Versionaplica  a,
       open.Sistema            s,
       LDC_VERSIONOBJETOS o
 Where t.Codigo = a.Codigo_Entrega
   And e.Codigo = a.Codigo_Empresa
   And e.Nit = s.Sistnitc
   And T.Codigo =
       (SELECT max(t1.codigo)
          FROM Ldc_Versionentrega t1
         WHERE T1.Codigo_Caso like '%OSF-186%')
         and t.Codigo = o.codigo_entrega
         --and o.objeto like '%100616%'
