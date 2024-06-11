 Select a.Aplica
    From   open.Ldc_Versionentrega t, open.Ldc_Versionempresa e, open.Ldc_Versionaplica a, open.Sistema s
    Where  t.Codigo = a.Codigo_Entrega
    And    e.Codigo = a.Codigo_Empresa
    And    e.Nit = s.Sistnitc
    and t.nombre_entrega='BSS_FAC_SMS_200342_8'
    --And    T.Codigo = (SELECT max(t1.codigo) FROM  Ldc_Versionentrega t1 WHERE  T1.Codigo_Caso like '%'||&isbNumeroCaso||'%');
