CREATE OR REPLACE PROCEDURE      "PAGOSMIGR" (ini number,fin number,pbd number) AS
/*******************************************************************
 PROGRAMA           :    pagosmigr
 FECHA            :    20/05/2014
 AUTOR            :    VICTOR HUGO MUNIVE ROCA
 DESCRIPCION        :    Migra la informacion de Pagos raalizados a pagos
 HISTORIA DE MODIFICACIONES
 AUTOR       FECHA    DESCRIPCION
 *******************************************************************/
   nuComplementoPR   number;
   nuComplementoSU   number;
   nuComplementoFA   number;
   nuComplementoCU   number;
   nuComplementoDI  number;
   COMPLEMENTO         NUMBER;
   vfecha_ini          DATE;
   vfecha_fin          DATE;
   vprograma           VARCHAR2 (100);
   verror              VARCHAR2 (2000);
   vcont               NUMBER;
   vcontLec            NUMBER := 0;
   vcontIns            NUMBER := 0;
   nuCuenta            number := null;
   nuConcepto          number := null;
   nuAnterior          number := 0;
   nuValor             number := 0;
   cursor cuPagos
      is
    SELECT /*+ parallel */
           1                 PAGOCONC,
           '123456789012345' PAGOSUBA,
           B.BANCHOMO        PAGOBANC,
           a.PAGOSUSC + nuComplementoSU       PAGOSUSC,
           trunc(a.PAGOFEPA) PAGOFEPA,
           a.PAGOVAPA        PAGOVAPA,
           a.PAGOFEGR        PAGOFEGR,
           'MIGRA'           PAGOUSUA,
           'MIGRA'           PAGOTERM,
           a.PAGOCUPO        PAGOCUPO,
           'MIGRA'           PAGOPROG,
           'EF'              PAGOTDCO,
           'C'               PAGOTIPA,
           null              PAGONUTR,
           null              PAGONUFI,
           null              PAGOPREF,
           null              PAGOCONF
         FROM  LDC_TEMP_PAGOS_sge A , LDC_MIG_banco B, SUSCRIPC C
           where  a.PAGOBANC  = B.CODIBANC AND
                  A.BASEDATO = PBD AND
                  B.BASEDATO = A.BASEDATO AND
                  C.SUSCCODI=A.PAGOSUSC+nuComplementoSU and
                  c.susccodi>=ini and
                  c.susccodi<fin;
    -- DECLARACION DE TIPOS.
   --
   TYPE tipo_cu_datos IS TABLE OF cuPAGOS%ROWTYPE;
   -- DECLARACION DE TABLAS TIPOS.
   --
   tbl_datos      tipo_cu_datos := tipo_cu_datos ();
   --- Control de errores
   nuLogError NUMBER;
   NUTOTALREGS NUMBER := 0;
   NUERRORES NUMBER := 0;
   nc number;
   SUBA SUCUBANC.SUBACODI%TYPE;
   sc number;
   fc date;
   bn number;
   sb varchar2(15);
   conci number;
BEGIN

    pkg_constantes.COMPLEMENTO(pbd,nuComplementoPR,nuComplementoSU,nuComplementoFA,nuComplementoCU,nuComplementoDI);
    UPDATE migr_rango_procesos set raprfeIN=sysdate,raprterm='P' where raprcodi=218 and raprbase=pbd and raprrain=INI and raprrafi=FIN;
    commit;

    VPROGRAMA := 'PAGOSmigr';
    vfecha_ini := SYSDATE;
    -- Inserta registro de inicio en el log
    PKLOG_MIGRACION.prInsLogMigra (218,218,1,vprograma,0,0,'Inicio','INICIO',nuLogError);
    -- Cargar Registros
   -- Recorre pagos
   OPEN cuPAGOS;
   LOOP
      --
      -- Borrar tablas     tbl_datos.
      --
      tbl_datos.delete;
      FETCH cuPAGOS
      BULK COLLECT INTO tbl_datos
      LIMIT 1000;
      NUTOTALREGS := NUTOTALREGS + TBL_DATOS.COUNT;
      FOR nuindice IN 1 .. tbl_datos.COUNT LOOP
          BEGIN
               vcontLec := vcontLec + 1;
               nuCuenta:= tbl_datos(nuindice).PAGOCUPO;
               select conccons into nc from concilia where concbanc=tbl_datos(nuindice).PAGObanc and concfunc=200 AND rownum=1;
               tbl_datos(nuindice).pagoconc:=nc;
               SUBA:=NULL;
               BEGIN
                    select subacodi
                           into suba
                           from sucubanc
                           where subabanc=tbl_datos(nuindice).PAGObanc and rownum=1
                    order by subacodi;
               exception
                    when others then
                         suba:=null;
               END;
               if suba is not null then
                  INSERT INTO PAGOS (PAGOCONC,PAGOSUBA,PAGOBANC,PAGOSUSC,PAGOFEPA,PAGOVAPA,PAGOFEGR,
                                 PAGOUSUA,PAGOTERM,PAGOCUPO,PAGOPROG,PAGOTDCO,PAGOTIPA,PAGONUTR,
                                 PAGONUFI,PAGOPREF,PAGOCONF)
                         VALUES (tbl_datos(nuindice).PAGOCONC,suba,tbl_datos(nuindice).PAGOBANC,
                                 tbl_datos(nuindice).PAGOSUSC,tbl_datos(nuindice).PAGOFEPA,tbl_datos(nuindice).PAGOVAPA,
                                 tbl_datos(nuindice).PAGOFEGR,tbl_datos(nuindice).PAGOUSUA,tbl_datos(nuindice).PAGOTERM,
                                 tbl_datos(nuindice).PAGOCUPO,tbl_datos(nuindice).PAGOPROG,tbl_datos(nuindice).PAGOTDCO,
                                 tbl_datos(nuindice).PAGOTIPA,tbl_datos(nuindice).PAGONUTR,tbl_datos(nuindice).PAGONUFI,
                                 tbl_datos(nuindice).PAGOPREF,tbl_datos(nuindice).PAGOCONF);
                  COMMIT;
               end if;
               vfecha_fin := SYSDATE;
           vcontIns := vcontIns + 1;
           COMMIT;
         EXCEPTION
         WHEN OTHERS THEN
              BEGIN
                   NUERRORES := NUERRORES + 1;
                   PKLOG_MIGRACION.prInsLogMigra ( 218,218,2,vprograma||vcontIns,0,0,
                   'BANCO '||TO_CHAR(tbl_datos(nuindice).PAGOBANC)||' SUCURSAL '||SUBA||' CONCILIACION '||TO_CHAR(tbl_datos(nuindice).pagoconc)||
                   'PAGO  : '||nuCuenta||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
              END;
         END;
      END LOOP;
      EXIT WHEN cuPAGOS%NOTFOUND;
   END LOOP;
   -- Cierra CURSOR.
   IF (cuPAGOS%ISOPEN)
      THEN
          --{
          CLOSE cuPAGOS;
          --}
   END IF;
   UPDATE migr_rango_procesos set raprfeFI=sysdate,raprterm='T' where raprcodi=218 and raprbase=pbd and raprrain=INI and raprrafi=FIN;
   COMMIT;
    --- Termina log
   PKLOG_MIGRACION.PRINSLOGMIGRA ( 218,218,3,VPROGRAMA,NUTOTALREGS,NUERRORES,'TERMINO PROCESO BD #regs: '||VCONTINS,'FIN',NULOGERROR);
  EXCEPTION
     WHEN OTHERS THEN
        BEGIN
           NUERRORES := NUERRORES + 1;
            PKLOG_MIGRACION.prInsLogMigra ( 218,218,2,vprograma||vcontIns,0,0,'Pago  : '||nuCuenta||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
        END;
END PAGOsmigr; 
/
