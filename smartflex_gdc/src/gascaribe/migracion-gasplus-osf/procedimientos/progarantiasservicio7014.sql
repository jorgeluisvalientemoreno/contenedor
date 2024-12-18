CREATE OR REPLACE procedure proGarantiasServicio7014 is
  cursor cuServicios is
  select *
  from servsusc
  where sesuserv = 7014;

  sqSEQ_GE_ITEM_WARRANTY number;
  nuResidencial	number := 4000051;
  nuComercial	number := 4000053;
  nuIndustrial	number := 4000054;

  nuItem number;
  sIS_ACTIVE1 varchar2(2);

  tWARRANY_DAYS1 number := 1460; -- 4 años de garantía
  sbError varchar2(2000);
  nuLogError NUMBER;

begin
	PKLOG_MIGRACION.prInsLogMigra ( 203,203,1,'proGarantiasServicio7014',0,0,'INICIA PROCESO','INICIO',nuLogError);
	sbError := null;

  for rtSesu in cuServicios loop

   sqSEQ_GE_ITEM_WARRANTY  := SEQ_GE_ITEM_WARRANTY.nextval;

   nuItem := null;

   if rtSesu.sesucate = 1 then
     nuItem := nuResidencial;
   elsif rtSesu.sesucate = 2 then
     nuItem := nuComercial;
   elsif rtSesu.sesucate = 3 then
     nuItem := nuIndustrial;
   end if;

   if (rtSesu.sesufein + tWARRANY_DAYS1 > sysdate) then
				sIS_ACTIVE1 := 'Y';
	 else
				sIS_ACTIVE1 := 'N';
   end if;

   if nuItem is not null then
        PK_MIGRACION_GARANTIAS.pr_registraWarranty(sqSEQ_GE_ITEM_WARRANTY,
														   nuItem,
														   rtSesu.sesunuse,
														   rtSesu.sesufein + tWARRANY_DAYS1,
														   sIS_ACTIVE1,
														   sbError);
        commit;
    end if;
  end loop;

  PKLOG_MIGRACION.prInsLogMigra ( 203,203,3,'proGarantiasServicio7014',0,0,'TERMINO PROCESO','FIN',nuLogError);
end proGarantiasServicio7014;
/
