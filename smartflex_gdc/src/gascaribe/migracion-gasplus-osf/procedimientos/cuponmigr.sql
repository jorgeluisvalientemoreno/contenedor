CREATE OR REPLACE PROCEDURE CUPONMIGR(INI NUMBER, FIN NUMBER, pbd number) AS
  /*******************************************************************
  PROGRAMA            :   CUPONmigr
  FECHA            :    20/05/2014
  AUTOR            :    VICTOR HUGO MUNIVE ROCA
  DESCRIPCION        :    Migra la informacion de Cupones
  HISTORIA DE MODIFICACIONES
  AUTOR       FECHA    DESCRIPCION
  *******************************************************************/
  nuComplementoPR number;
  nuComplementoSU number;
  nuComplementoFA number;
  nuComplementoCU number;
  nuComplementoDI number;
  susc            number;
  CURSOR pagados is
    select /*+ parallel */
     c.cupocodi cupocodi,
     c.cupofact cupofact,
     c.cupovalo cupovalo,
     c.cupofech cupofech,
     c.cuposusc cuposusc,
     c.basedato bdc,
     c.cupocuco cuenta,
     p.pagofegr pagofegr
      from migra.ldc_temp_cupon_sge c, suscripc s, ldc_temp_pagos_sge p
     where c.cupoflpa = 'S'
       and c.basedato = pbd
       and c.cuposusc + nucomplementosu = s.susccodi
       and s.SUSCCODI >= INI
       AND s.SUSCCODI < FIN
       and p.basedato = c.basedato
       and p.pagosusc = c.cuposusc
       and p.pagocupo = c.cupocodi
     /*  and NOT EXISTS
     (SELECT 1 FROM cupon x WHERE x.cuponume = c.cupocodi)*/;
  cursor cc_cuponnp is
    select /*+ parallel */
     c.cupocodi cupocodi,
     c.cupovalo cupovalo,
     c.cupofech cupofech,
     c.cuposusc cuposusc,
     c.cupofact cupofact,
     c.cupocuco cuenta
      from migra.ldc_temp_cupon_sge c, suscripc s
     where c.cupoflpa = 'N'
       and s.susccodi = c.cuposusc + nucomplementosu
       AND c.BASEDATO = PBD
       AND s.SUSCCODI >= INI
       AND s.SUSCCODI < FIN
       /*and NOT EXISTS
     (SELECT 1 FROM cupon x WHERE x.cuponume = c.cupocodi)*/;
  VAN         NUMBER;
  FACTUR      NUMBER;
  nuLogError  number;
  nuTotalRegs number := 0;
  nuErrores   number := 0;
  sw          number;
  fff         number;
BEGIN
  UPDATE migr_rango_procesos
     set raprfeIN = sysdate, raprterm = 'P'
   where raprcodi = 216
     and raprbase = pbd
     and raprrain = INI
     and raprrafi = FIN;
  COMMIT;
  pkg_constantes.COMPLEMENTO(pbd,
                             nuComplementoPR,
                             nuComplementoSU,
                             nuComplementoFA,
                             nuComplementoCU,
                             nuComplementoDI);

  -- Inserta registro de inicio en el log
  PKLOG_MIGRACION.prInsLogMigra(216,
                                216,
                                1,
                                'CUPONmigr',
                                0,
                                0,
                                'Inicia Proceso',
                                'INICIO',
                                nuLogError);
  -- Inserta los cupones no pagados
  van := 0;
  for x in cc_cuponnp loop
    BEGIN
      begin
        select factsusc
          into susc
          from factura
         where factcodi = x.cupofact + nucomplementofa;
        if susc = x.cuposusc + nucomplementosu then
          factur := x.cupofact + nucomplementofa;
          sw     := 0;
        else
          sw := 1;
          PKLOG_MIGRACION.prInsLogMigra(216,
                                        216,
                                        2,
                                        'CUPONmigr',
                                        0,
                                        0,
                                        'Cupon no pagado #' || x.cupocodi ||
                                        ' basedato=' || pbd ||
                                        '. La factura no corresponde al suscriptor del cupon',
                                        1,
                                        nuLogError);
        end if;
      exception
        when no_data_found then
          fff := x.cuposusc + nucomplementosu;
          select /*+ INDEX (FACTURA ix_factura08) */
           max(factcodi)
            into factur
            from factura
           where factsusc = fff;
          sw := 0;
      end;
      if sw = 0 then
        BEGIN
          insert into cupon
            (CUPONUME,
             CUPOTIPO,
             CUPODOCU,
             CUPOVALO,
             CUPOFECH,
             CUPOPROG,
             CUPOCUPA,
             CUPOSUSC,
             CUPOFLPA)
          values
            (x.cupocodi,
             decode(x.cuenta,null,'FA','CC'),
             decode(x.cuenta,null,factur,x.cuenta),
             x.cupovalo,
             x.cupofech,
             'MIGRA',
             NULL,
             x.CUPOSUSC + nucomplementosu,
             'N');
          van := van + 1;
        EXCEPTION
          WHEN OTHERS THEN
            PKLOG_MIGRACION.prInsLogMigra(216,
                                          216,
                                          2,
                                          'CUPONmigr',
                                          0,
                                          0,
                                          'Cupon no pagado #' || x.cupocodi ||
                                          ' basedato=' || pbd ||
                                          '. Error indeterminado insertando cupon. ' ||
                                          sqlerrm,
                                          to_char(sqlcode),
                                          nuLogError);
        end;
      end if;
    end;
    if van = 1000 then
      van := 0;
      commit;
    end if;
  END LOOP;
  van := 0;
  -- Inserta los cupones ya pagados
  FOR cp IN pagados LOOP
    begin
      begin
        select factsusc
          into susc
          from factura
         where factcodi = cp.cupofact + nucomplementofa;
        if susc = cp.cuposusc + nucomplementosu then
          factur := cp.cupofact + nucomplementofa;
          sw     := 0;
        else
          sw := 1;
          PKLOG_MIGRACION.prInsLogMigra(216,
                                        216,
                                        2,
                                        'CUPONmigr',
                                        0,
                                        0,
                                        'Cupon pagado #' || cp.cupocodi ||
                                        ' basedato=' || pbd ||
                                        '. La factura no corresponde al suscriptor del cupon',
                                        1,
                                        nuLogError);
        end if;
      exception
        when no_data_found then
          if cp.pagofegr > sysdate - 180 then
            PKLOG_MIGRACION.prInsLogMigra(216,
                                          216,
                                          2,
                                          'CUPONmigr',
                                          0,
                                          0,
                                          'Cupon pagado #' || cp.cupocodi ||
                                          ' basedato=' || pbd ||
                                          '. El cupon corresponde a un pago de menos de 180 dias y no se puede determinar la factura.',
                                          to_char(sqlcode),
                                          nuLogError);
            sw := 1;
          else
            factur := -1;
            sw     := 0;
          end if;
        when others then
          sw := 1;
          PKLOG_MIGRACION.prInsLogMigra(216,
                                        216,
                                        2,
                                        'CUPONmigr',
                                        0,
                                        0,
                                        'Cupon pagado #' || cp.cupocodi ||
                                        ' basedato=' || pbd ||
                                        '. Error indeterminado determinando factura del cupon. ' ||
                                        sqlerrm,
                                        to_char(sqlcode),
                                        nuLogError);
      end;
      if sw = 0 then
        BEGIN
          insert into cupon
            (CUPONUME,
             CUPOTIPO,
             CUPODOCU,
             CUPOVALO,
             CUPOFECH,
             CUPOPROG,
             CUPOCUPA,
             CUPOSUSC,
             CUPOFLPA)
          values
            (cp.cupocodi,
             decode(cp.cuenta,null,'FA','CC'),
             decode(cp.cuenta,null,factur,cp.cuenta),
             cp.cupovalo,
             cp.cupofech,
             'MIGRA',
             NULL,
             Cp.CUPOSUSC + nucomplementosu,
             'S');
          van := van + 1;
        EXCEPTION
          WHEN OTHERS THEN
            PKLOG_MIGRACION.prInsLogMigra(216,
                                          216,
                                          2,
                                          'CUPONmigr',
                                          0,
                                          0,
                                          'Cupon pagado #' || cp.cupocodi ||
                                          ' basedato=' || pbd ||
                                          '. Error indeterminado insertando cupon. ' ||
                                          sqlerrm,
                                          to_char(sqlcode),
                                          nuLogError);
        end;
      END IF;
    end;
    if van = 1000 then
      van := 0;
      commit;
    end if;
  end loop;
  UPDATE migr_rango_procesos
     set raprfeFI = sysdate, raprterm = 'T'
   where raprcodi = 216
     and raprbase = pbd
     and raprrain = INI
     and raprrafi = FIN;
  COMMIT;
  -- Termina Log
  PKLOG_MIGRACION.prInsLogMigra(216,
                                216,
                                3,
                                'CUPONmigr',
                                0,
                                nuErrores,
                                'TERMINO PROCESO #regs: ' || 0,
                                'FIN',
                                nuLogError);
EXCEPTION
  WHEN OTHERS THEN
    PKLOG_MIGRACION.prInsLogMigra(216,
                                  216,
                                  2,
                                  'CUPONmigr',
                                  0,
                                  0,
                                  'Error: ' || sqlerrm,
                                  to_char(sqlcode),
                                  nuLogError);
END; 
/
