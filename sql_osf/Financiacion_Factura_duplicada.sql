select lcc.*, rowid from OPEN.LD_CUPON_CAUSAL lcc;
select df.*, rowid from OPEN.duplicado_factura df;
select *
  from OPEN.LD_CUPON_CAUSAL lcc, OPEN.duplicado_factura df
 where lcc.cuponume = df.cuponume;

select d.*
  from OPEN.DIFERIDO d
 where d.difesusc = 526461
   and d.difenudo = 'PP-92861193';
