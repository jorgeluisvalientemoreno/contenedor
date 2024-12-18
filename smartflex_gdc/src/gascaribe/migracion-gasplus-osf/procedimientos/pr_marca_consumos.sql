CREATE OR REPLACE PROCEDURE      pr_marca_consumos(NUMINICIO   NUMBER,
                                              NUMFINAL    NUMBER,
                                              inubasedato number)
/************************************************************************
    Copyright (c) 2014 ROLLOUT GASCARIBE.
  
    NOMBRE       : pr_marca_consumos3.prc
    AUTOR        : SINCECOMP- SAMUEL PACHECO
    FECHA        : 22-10-2014
    DESCRIPCION  : Procedimiento mediante el cual se obtiene la informacion
                   de CARGO Y MARCA CONSUMO
  
    Parametros de Entrada
  
    Parametros de Salida
  
    Historia de Modificaciones
    Autor       Fecha        Descripcion
  ************************************************************************/
 AS

  --<<
  -- Declaracion de variables
  -->>
  vfecha_ini DATE;
  vfecha_fin DATE;
  vprograma  VARCHAR2(100);
  verror     VARCHAR2(2000);
  vcontLec   NUMBER := 0;
  vcontIns   NUMBER := 0;
  van        number;
  CS         NUMBER;
  nuLogError NUMBER;
  vaComod    VARCHAR2(100);

  cursor cuCargos is
    select /*+parallel*/ cargconc, cargdoso, cargnuse, CARGPECO, cargpefa, ROWID
      from cargos G
     where cargconc = 31;

  cursor cuConsumo(inucargnuse number, inuCARGPECO number, inucargpefa number) is
    select /*+ index(conssesu ix_conssesu02) */
     COSSCONS
      from conssesu
     where COSSSESU = inucargnuse
       and cosspecs = inuCARGPECO
       and cosspefa = inucargpefa
       and cosstcon = 1
       and cossmecc = 4
       and rownum = 1;

  cursor cuConsumoAJCC(inucargnuse number, inucargpefa number, inucargpeco number) is
    select /*+ index(conssesu ix_conssesu02) */
     COSSCONS
      from conssesu a
     where COSSSESU = inucargnuse
       and cosspefa = inucargpefa
       and cosspecs = inucargpeco
       and cosstcon = 1
       and exists (select /*+ index(conssesu ix_conssesu11) */
             1
              from open.conssesu b
             where a.cosspecs = b.cosspecs
               and a.cosspefa = b.cosspefa
               and a.cosssesu = b.cosssesu
               and cossmecc in (2, 5)
               and a.cosscoca = b.cosscoca)
       and cossmecc = 4
       and rownum = 1;

  nuConsumo  conssesu.COSSCONS%type;
  nuCommit   number := 0;
  nuCantidad number := 0;
begin
  PKLOG_MIGRACION.prInsLogMigra(272,
                                272,
                                1,
                                'pr_marca_consumos',
                                0,
                                0,
                                'Inicia Proceso',
                                'INICIO',
                                nuLogError);
  UPDATE MIGR_RANGO_PROCESOS
     SET RAPRTERM = 'P', RAPRFEIN = sysdate
   WHERE raprbase = inubasedato
     AND raprrain = NUMINICIO
     AND raprrafi = NUMFINAL
     AND raprcodi = 272;
  commit;

  MODIFYCARGPECO(inubasedato);  
    
  EXECUTE IMMEDIATE 'ALTER SYSTEM FLUSH SHARED_POOL';

  EXECUTE IMMEDIATE ('BEGIN dbms_stats.gather_table_stats(ownname=>' ||
                    CHR(39) || 'OPEN' || CHR(39) || ',tabname=>' ||
                    CHR(39) || 'CONSSESU' || CHR(39) || ',
                        estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
  cascade=>true,method_opt=>' || CHR(39) ||
                    'for all columns size AUTO' || CHR(39) ||
                    ', DEGREE => 10); END;');

  for rcCargos in cuCargos loop
  
    -- if (rcCargos.cargconc = 31) then
  
    if ((rcCargos.cargdoso liKE 'CO%') and
       (rcCargos.cargdoso not like '%AJCC%')) then
    
      nuConsumo := null;
    
      for rcConsumo in cuConsumo(rcCargos.cargnuse,
                                 rcCargos.CARGPECO,
                                 rcCargos.cargpefa) loop
        nuConsumo := rcConsumo.COSSCONS;
      end loop;
    
      if (nuConsumo is not null) then
      
        update cargos
           set cargcodo = nuConsumo
         where CARGOS.rowid = rcCargos.rowid;
      
        nuCommit := nuCommit + 1;
      
        if (nuCommit > 5000) then
          nuCommit := 0;
          commit;
        end if;
      
        nuCantidad := nuCantidad + 1;
      
      end if;
    
    else
    
      if (rcCargos.cargdoso liKE 'CO%AJCC%') then
      
        nuConsumo := null;
      
        for rcConsumo in cuConsumoAJCC(rcCargos.cargnuse, rcCargos.cargpefa, rcCargos.cargpeco) loop
          nuConsumo := rcConsumo.COSSCONS;
        end loop;
      
        if (nuConsumo is not null) then
        
          update cargos
             set cargcodo = nuConsumo
           where CARGOS.rowid = rcCargos.rowid;
        
          commit;
        
          nuCantidad := nuCantidad + 1;
        
        end if;
      
      end if;
    
    end if;
    --    end if;
  
  end loop;

  commit;

  PKLOG_MIGRACION.prInsLogMigra(272,
                                272,
                                3,
                                'pr_marca_consumos',
                                0,
                                0,
                                'Termina Proceso',
                                'FIN',
                                nuLogError);
  UPDATE MIGR_RANGO_PROCESOS
     SET RAPRTERM = 'T', RAPRFEFI = sysdate
   WHERE raprbase = inubasedato
     AND raprrain = NUMINICIO
     AND raprrafi = NUMFINAL
     AND raprcodi = 272;
  commit;

end; 
/
