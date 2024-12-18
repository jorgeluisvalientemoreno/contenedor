CREATE OR REPLACE PROCEDURE PR_HOMOLOGACIONES(inubasedato number) AS
--  --SELECT * FROM ldc_mig_sectoper
  procedure categorimenosuno is
    cursor Cudatos is
      select distinct predcate
        from ldc_temp_predio_sge a
       where not exists
       (select * from ldc_mig_categori b where b.codicate = a.predcate)
         and predcate IS not null;
    nudepadummy number;
    nulocadummy number;
    nusectdummy number;
  begin
    for r in Cudatos loop
      insert into ldc_mig_categori values (r.predcate, 1);
      commit;
    end loop;
  end;

  -- ldc_mig_banco
  procedure bancomenosuno is
    cursor Cudatos is
      select distinct pagobanc
        from ldc_temp_pagos_sge a
       where not exists
       (select * from ldc_mig_banco b where b.codibanc = a.pagobanc and a.basedato=b.basedato)
        and a.basedato=inubasedato
        and pagobanc IS not null;

    nudepadummy number;
    nulocadummy number;
    nusectdummy number;
    nubancodummy number;

  begin

    if inubasedato in (1,2,3) then

     nubancodummy:=700;

    else

        if inubasedato =4 then

            nubancodummy:=232;

        else

            if inubasedato=5 then

                nubancodummy:=913;

            end if;

        end if;
    end if;

    for r in Cudatos loop
      insert into ldc_mig_banco values (r.pagobanc,nubancodummy,inubasedato);
      commit;
    end loop;
  end;

-- tipo poliza
    procedure polizamenosuno is
    cursor Cudatos is
      select distinct posuprli,posuaseg
        from ldc_temp_polisusc_sge a
       where not exists
       (select * from ldc_mig_tipopoli b where b.tipocodi = a.posuprli and b.tipocuad =a.posuaseg and a.basedato=b.basedato)
        and a.basedato=inubasedato
        and posuprli IS not null
        and posuaseg is not null;


  begin


    for r in Cudatos loop
      insert into ldc_mig_tipopoli values (r.posuprli, r.posuaseg,1,inubasedato);
      commit;
    end loop;
  end;


  -- LDC_MIG_SUBCATEG
  procedure sectopermenosuno is
    cursor Cudatos is
      select distinct preddepa, predloca, predseop
        from ldc_temp_predio_sge a
       where not exists (select *
                from ldc_mig_sectoper b
               where b.codidepa = a.preddepa
                 AND b.codiloca = a.predloca
                 AND codisect = a.predseop)
         and predseop IS not null
         AND preddepa IS not null
         AND predloca IS not null;
    nudepadummy number;
    nulocadummy number;
    nusectdummy number;
    nubarrdummy number;
  begin
    IF INUBASEDATO = 1 THEN
      nudepadummy := 8192;
      nulocadummy := 8193;
      nusectdummy := 8194;
      nubarrdummy := 8195;
    END IF;
    if INUBASEDATO = 2 then
      nudepadummy := 8192;
      nulocadummy := 8193;
      nusectdummy := 8194;
      nubarrdummy := 8195;
    end if;
    if INUBASEDATO = 3 then
      nudepadummy := 8192;
      nulocadummy := 8193;
      nusectdummy := 8194;
      nubarrdummy := 8195;
    end if;
    IF INUBASEDATO = 4 THEN
      nudepadummy := 8190;
      nulocadummy := 8191;
      nusectdummy := 8192;
      nubarrdummy := 8193;
    END IF;
    IF INUBASEDATO = 5 THEN
      nudepadummy := 8189;
      nulocadummy := 8190;
      nusectdummy := 8191;
      nubarrdummy := 8192;
    END IF;
    for r in Cudatos loop
      insert into ldc_mig_sectoper
      values
        (r.preddepa, r.predloca, r.predseop, nusectdummy);
      commit;
    end loop;
  end;
  -- LDC_MIG_SUBCATEG
  procedure subcategmenosuno is
    cursor Cudatos is
      select distinct predcate, predsuca
        from ldc_temp_predio_sge a
       where not exists (select *
                from ldc_mig_subcateg b
               where b.codicate = a.predcate
                 AND b.codisuca = a.predsuca)
         and predcate IS not null
         and predsuca IS not null;

     cursor Cudatos2 is
      select distinct sesucate, sesusuca
        from ldc_temp_servsusc_sge a
       where not exists (select *
                from ldc_mig_subcateg b
               where b.codicate = a.sesucate
                 AND b.codisuca = a.sesusuca)
         and sesucate IS not null
         and sesusuca IS not null;

  begin
    for r in Cudatos loop
      insert into ldc_mig_subcateg values (r.predcate, r.predsuca, -1, -1);
      commit;
    end loop;

    for r in Cudatos2 loop
      insert into ldc_mig_subcateg values (r.sesucate, r.sesusuca, -1, -1);
      commit;
    end loop;

  end;
  -- LDC_MIG_BARRIO
  procedure barriomenosuno is
    cursor Cudatos is
      select distinct predloca, preddepa, predbarr
        from ldc_temp_predio_sge a
       where not exists (select *
                from ldc_mig_barrio b
               where b.codidepa = a.preddepa
                 AND b.codiloca = a.predloca
                 AND b.codibarr = predbarr)
         and predloca IS not null
         and preddepa IS not null
         and predbarr IS not null;
    nudepadummy number;
    nulocadummy number;
    nusectdummy number;
    nubarrdummy number;
  begin
    IF INUBASEDATO = 1 THEN
      nudepadummy := 8192;
      nulocadummy := 8193;
      nusectdummy := 8194;
      nubarrdummy := 8195;
    END IF;
    if INUBASEDATO = 2 then
      nudepadummy := 8192;
      nulocadummy := 8193;
      nusectdummy := 8194;
      nubarrdummy := 8195;
    end if;
    if INUBASEDATO = 3 then
      nudepadummy := 8192;
      nulocadummy := 8193;
      nusectdummy := 8194;
      nubarrdummy := 8195;
    end if;
    IF INUBASEDATO = 4 THEN
      nudepadummy := 8190;
      nulocadummy := 8191;
      nusectdummy := 8192;
      nubarrdummy := 8193;
    END IF;
    IF INUBASEDATO = 5 THEN
      nudepadummy := 8189;
      nulocadummy := 8190;
      nusectdummy := 8191;
      nubarrdummy := 8192;
    END IF;
    for r in Cudatos loop
      insert into ldc_mig_barrio
      values
        (r.preddepa,
         r.predloca,
         r.predbarr,
         nubarrdummy,
         nudepadummy,
         nulocadummy);
      commit;
    end loop;
  end;
  -- LDC_MIG_LOCALIDAD
  procedure localidadmenosuno is
    cursor Cudatos is
      select distinct predloca, preddepa
        from ldc_temp_predio_sge a
       where not exists (select *
                from ldc_mig_localidad b
               where b.codidepa = a.preddepa
                 AND b.codiloca = a.predloca)
         and preddepa IS not null
         and predloca IS not null;
    nudepadummy number;
    nulocadummy number;
  begin
    IF INUBASEDATO = 1 THEN
      nudepadummy := 8192;
      nulocadummy := 8193;
    END IF;
    if INUBASEDATO = 2 then
      nudepadummy := 8192;
      nulocadummy := 8193;
    end if;
    if INUBASEDATO = 3 then
      nudepadummy := 8192;
      nulocadummy := 8193;
    end if;
    IF INUBASEDATO = 4 THEN
      nudepadummy := 8190;
      nulocadummy := 8191;
    END IF;
    IF INUBASEDATO = 5 THEN
      nudepadummy := 8189;
      nulocadummy := 8190;
    END IF;
    for r in Cudatos loop
      insert into ldc_mig_localidad
      values
        (r.preddepa, r.predloca, nudepadummy, nulocadummy);
      commit;
    end loop;
  end;
  -- ldc_mig_obselect
  procedure obselectmenosuno is
    cursor Culectoble is
      select distinct lectoble
        from ldc_temp_lectura_sge a
       where not exists
       (select * from ldc_mig_obselect b where b.oblecodi = a.lectoble)
         and lectoble IS not null;
  begin
    for r in Culectoble loop
      insert into ldc_mig_obselect values (r.lectoble, -1);
      commit;
    end loop;
  end;
  -- ldc_mig_ciclo
  ---------------------------------------------
  procedure CICLOMENOSUNO is
    cursor cuciclo is
      select distinct predcicl, preddepa, predloca, a.basedato
        from ldc_temp_predio_SGE a, migra.ldc_temp_ciclo_sge b
       WHERE predcicl = ciclcodi
         AND preddepa = cicldepa
         AND predloca = ciclloca
         AND a.basedato = b.basedato
         AND a.basedato = inubasedato
         AND not exists (select *
                from ldc_mig_ciclo b
               where codicicl = predcicl
                 AND b.database = a.basedato)
         AND PREDCICL IS NOT NULL;
     cursor cuciclo2 is
      select distinct sesucicl, sesudepr, sesulopr, a.basedato
        from ldc_temp_servsusc_SGE a, migra.ldc_temp_ciclo_sge b
       WHERE sesucicl = ciclcodi
         AND sesudepr = cicldepa
         AND sesulopr = ciclloca
         AND a.basedato = b.basedato
         AND a.basedato = inubasedato
         AND not exists (select *
                from ldc_mig_ciclo b
               where codicicl = sesucicl
                 AND b.database = a.basedato)
         AND sesuCICL IS NOT NULL;

      cursor cuciclo3 is
      select distinct factcicl, factdepa, factloca, a.basedato
        from ldc_temp_FACTURA_SGE a, migra.ldc_temp_ciclo_sge b
       WHERE factcicl = ciclcodi
         AND factdepa = cicldepa
         AND factloca = ciclloca
         AND a.basedato = b.basedato
         AND a.basedato = inubasedato
         AND not exists (select *
                from ldc_mig_ciclo b
               where codicicl = factcicl
                 AND b.database = a.basedato)
         AND factcicl IS NOT NULL;
  begin
    for r in cuciclo loop
      insert into ldc_mig_ciclo
      values
        (r.predcicl,
         9999,
         r.preddepa,
         r.predloca,
         decode(r.basedato,
                1,
                'GASBQ',
                2,
                'GASSM',
                3,
                'GASVD',
                4,
                'SURTIGAS',
                5,
                'EFIGAS'),
         r.basedato);
      commit;
    end loop;

     for r in cuciclo2 loop
      insert into ldc_mig_ciclo
      values
        (r.sesucicl,
         9999,
         r.sesudepr,
         r.sesulopr,
         decode(r.basedato,
                1,
                'GASBQ',
                2,
                'GASSM',
                3,
                'GASVD',
                4,
                'SURTIGAS',
                5,
                'EFIGAS'),
         r.basedato);
      commit;
    end loop;

     for r in cuciclo3 loop
      insert into ldc_mig_ciclo
      values
        (r.factcicl,
         9999,
         r.factdepa,
         r.factloca,
         decode(r.basedato,
                1,
                'GASBQ',
                2,
                'GASSM',
                3,
                'GASVD',
                4,
                'SURTIGAS',
                5,
                'EFIGAS'),
         r.basedato);
      commit;
    end loop;
  end;
  -- ldc_mig_concepto
  ----------------------------------------------
  procedure conceptomenosuno is
    cursor cuconcepto is
      select distinct cargconc, basedato
        from ldc_temp_cargos_sge a
       where not exists (select *
                from ldc_mig_concepto b
               where b.database = a.basedato
                 and b.codiconce = a.cargconc)
         and a.cargconc IS not null;
  begin
    for c in cuconcepto loop
      insert into ldc_mig_concepto values (c.cargconc, 573, c.basedato);
      commit;
    end loop;
  end;
  -- LDC_ESTADOS_SERV_HOMO
  ------------------------------------------------
  procedure estadosmenosuno is
    cursor cuestados is
      select distinct a.sesueste, a.sesuesfi
        from ldc_temp_SERVSUSC_sge a
       where not exists (select *
                from LDC_ESTADOS_SERV_HOMO b
               where b.ESTADO_TECNICO = a.sesueste
                 AND a.sesuesfi = b.ESTADO_FINANCI)
         AND a.sesueste IS not null
         AND a.sesuesfi IS not null;
  begin

    for c in cuestados loop
      insert into LDC_ESTADOS_SERV_HOMO
      values
        (c.sesueste, c.sesuesfi, 1, 1, 'A', 'N', 1);
      commit;
    end loop;
  end;

  -- ldc_mig_causcarg
  ----------------------------------------------
  procedure causcargmenosuno is
    cursor cuconcepto is
      select distinct cargcaca
        from ldc_temp_cargos_sge a
       where not exists
       (select * from ldc_mig_causcarg b where b.codicaca = a.cargcaca)
         AND a.cargcaca IS not null;
  begin
    for c in cuconcepto loop
      insert into ldc_mig_causcarg values (c.cargcaca, 53);
      commit;
    end loop;
  end;

  -- ldc_mig_cuadcont
  ----------------------------------------------
  procedure cuadcontDummy is
    cursor cuadcont is
      select distinct medicuad
        from ldc_temp_medidor_sge t
       where not exists
       (select * from ldc_mig_cuadcont x where x.cuadcodi = t.medicuad)
         and basedato = inubasedato
         and medicuad is not null
      union
      select distinct y.eixbbcua medicuad
        from ldc_temp_exitebod_sge y
       where not exists
       (select * from ldc_mig_cuadcont x where x.cuadcodi = y.eixbbcua)
         and basedato = inubasedato
         and y.eixbbcua is not null;
  begin
    for c in cuadcont loop
      insert into ldc_mig_cuadcont values (c.medicuad, 1, inubasedato);
      commit;
    end loop;
  end;

  -- ldc_mig_estamedi
  ----------------------------------------------
  procedure estamediDummy is
    cursor cuestamedi is
      select distinct nvl(y.mediesme, -1) mediesme
        from ldc_temp_medidor_sge y
       where not exists
       (select * from ldc_mig_estamedi x where x.codiesme = nvl(y.mediesme, -1));
  begin
    for c in cuestamedi loop
      insert into ldc_mig_estamedi values (c.mediesme, 1);
      commit;
    end loop;
  end;
  -- ldc_mig_estamedi
  ----------------------------------------------
  procedure sesuplsuDummy is
    cursor cusesuplsu is
      select distinct nvl(y.sesuplsu, -1) sesuplsu
        from ldc_temp_servsusc_sge y
       where not exists
       (select 1 from LDC_MIG_PLANSUSC x where x.codiplsu = y.sesuplsu and x.basedato=y.basedato)
         and basedato = inubasedato;
    nudummyplan number;
  begin
    if inubasedato in (1,2,3) then
        nudummyplan:=25;
    else
        if inubasedato =4 then
            nudummyplan:=28;
        else
            if inubasedato=5 then

             nudummyplan:=57;

            end if;


        end if;

    end if;


    for c in cusesuplsu loop
      insert into LDC_MIG_PLANSUSC values (c.sesuplsu, nudummyplan, inubasedato);
      commit;
    end loop;
  end;
  
    procedure Tiposuscmenosuno is
    cursor Cudatos is
     select distinct susctisu
  from ldc_temp_suscripc_sge
 where not exists
 (select 1 from migra.ldc_mig_tiposusc b where b.coditisu = susctisu);
 
    nudepadummy number;
    nulocadummy number;
    nusectdummy number;
  begin
    for r in Cudatos loop
      insert into migra.ldc_mig_tiposusc values (r.susctisu , -1);
      commit;
    end loop;
  end;
  

BEGIN
  categorimenosuno;
  sectopermenosuno;
  subcategmenosuno;
  barriomenosuno;
  localidadmenosuno;
  obselectmenosuno;
  ciclomenosuno;
  bancomenosuno;
  conceptomenosuno;
  causcargmenosuno;
  estadosmenosuno;
  cuadcontDummy;
  estamediDummy;
  sesuplsuDummy;
  polizamenosuno;
  Tiposuscmenosuno;
END; 
/
