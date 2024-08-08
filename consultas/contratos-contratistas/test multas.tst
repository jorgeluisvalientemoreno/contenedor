PL/SQL Developer Test script 3.0
16
begin
  -- Call the procedure
  ldc_boordenes.procdiasatencionorden(idtassigned_date => :idtassigned_date,
                                      idtejeclegal_date => :idtejeclegal_date,
                                      inudepartamento => :inudepartamento,
                                      inulocalidad => :inulocalidad,
                                      inutipotrabajo => :inutipotrabajo,
                                      inuactividad => :inuactividad,
                                      inucausal => :inucausal,
                                      isbestado => :isbestado,
                                      inuproveedor => :inuproveedor,
                                      onutiempo => :onutiempo,
                                      onuporcentaje => :onuporcentaje,
                                      onuvalor => :onuvalor,
                                      onudias => :onudias);
end;
13
idtassigned_date
1
13/04/2015
12
idtejeclegal_date
1
27/10/2015
12
inudepartamento
1
3
3
inulocalidad
1
55
3
inutipotrabajo
1
12150
4
inuactividad
1
100002509
4
inucausal
1
9944
3
isbestado
1
L
5
inuproveedor
1
3337
4
onutiempo
1
15
3
onuporcentaje
0
3
onuvalor
1
5000
4
onudias
1
127
3
0
