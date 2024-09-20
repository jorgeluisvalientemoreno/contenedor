SELECT t.cocodesc, i.* /*cogecons*/ FROM open.ic_compgene i, open.ic_compcont t
 WHERE cogecoco = cococodi --IN (SELECT cococodi FROM open.ic_compcont WHERE cocotcco = 2)
   AND cocotcco = 2
   AND cogefein >= ('&FECHA_INICIAL')
   AND cogefefi <= ('&FECHA_FINAL')
