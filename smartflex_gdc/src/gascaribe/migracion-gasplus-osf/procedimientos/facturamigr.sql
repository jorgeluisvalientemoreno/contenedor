CREATE OR REPLACE PROCEDURE      "FACTURAMIGR" (NUMINICIO number, numFinal number,pbd number ) AS
  /*******************************************************************
 PROGRAMA        :    FACTURAmigr
 FECHA            :    16/05/2014
 AUTOR            :    VICTOR HUGO MUNIVE ROCA
 DESCRIPCION    :    Migra la informacion de las facturas
 HISTORIA DE MODIFICACIONES
 AUTOR       FECHA    DESCRIPCION
 *******************************************************************/
    nuComplementoPR   number;
   nuComplementoSU   number;
   nuComplementoFA   number;
   nuComplementoCU   number;
   nuComplementoDI  number;
   vfecha_ini          DATE;
   vfecha_fin          DATE;
   vprograma           VARCHAR2 (100);
   Verror              Varchar2 (2000);
   vcont               NUMBER := 0;
   vcontLec            NUMBER := 0;
   vcontIns            NUMBER := 0;
   nuFactura           number:= 0;
   LOCAHOMO            NUMBER := 0;
   DEPAHOMO            NUMBER := 0;
   
   CURSOR cuFactura
   IS
   SELECT a.*, c.susciddi,F.GEO_LOCA_FATHER_ID,E.geograp_location_id
          FROM LDC_TEMP_FACTURA_sge a,
               suscripc             c,
               AB_ADDRESS           E,
               GE_GEOGRA_LOCATION   F            
          WHERE 
                A.Basedato   = pbd
                And a.factsusc+nucomplementosu   = c.susccodi      
                AND C.susciddi =  E.ADDRESS_ID 
                AND E.geograp_location_id = F.GEOGRAP_LOCATION_ID                         
                AND A.FACTSUSC   >= NUMINICIO
                and a.factsusc   < numFinal;
   -- DECLARACION DE TIPOS.
   --
   nucicloho number;
   nuperifact number;
   
   cursor cuLDC_MIG_CICLO  is
   select CODICICL,CICLHOMO  from LDC_MIG_CICLO where DATABASE =pbd;
   
   TYPE tycuLDC_MIG_CICLO IS TABLE OF cuLDC_MIG_CICLO%ROWTYPE INDEX BY BINARY_INTEGER;
   vtyLDC_MIG_CICLO       tycuLDC_MIG_CICLO;
   vtyLDC_MIG_CICLO_copia tycuLDC_MIG_CICLO;
  
   cursor cuPERIFACT  is   
   select pefacicl||substr(pefaano,3)||PEFAMES PEFALLAVE,PEFACODI  from PERIFACT where pefacodi<>-1;
   
   TYPE tycuPERIFACT IS TABLE OF cuPERIFACT%ROWTYPE INDEX BY BINARY_INTEGER;
   vtyPERIFACT       tycuPERIFACT;
   vtyPERIFACT_COPIA tycuPERIFACT;
    
   nuciclohomo number; 
   TYPE tipo_cu_datos IS TABLE OF cuFactura%ROWTYPE;
   -- DECLARACION DE TABLAS TIPOS.
   --
   tbl_datos      tipo_cu_datos := tipo_cu_datos ();
--- Control de errores
   nuLogError NUMBER;
   NUTOTALREGS NUMBER := 0;
   NUERRORES NUMBER := 0;
BEGIN
   update migr_rango_procesos set raprfein=sysdate,RAPRTERM='P' where raprcodi=183 and raprbase=pbd and raprrain=numinicio and raprrafi=NUMFINAL;
   COMMIT;
   pkg_constantes.COMPLEMENTO(pbd,nuComplementoPR,nuComplementoSU,nuComplementoFA,nuComplementoCU,nuComplementoDI);
    ---
   VPROGRAMA := 'FACTURAmigr';
   vfecha_ini := SYSDATE;
   -- Inserta registro de inicio en el log
   PKLOG_MIGRACION.prInsLogMigra (183,183,1,vprograma,0,0,'Inicia Proceso','INICIO',nuLogError);
   -- Cargar Registros
   vcontLec := 0;
   vcontIns := 1;
  
   vtyLDC_MIG_CICLO.delete;
   vtyLDC_MIG_CICLO_copia.delete;
    
   OPEN cuLDC_MIG_CICLO;
   FETCH cuLDC_MIG_CICLO BULK COLLECT INTO vtyLDC_MIG_CICLO;
   CLOSE cuLDC_MIG_CICLO;
    
    IF (vtyLDC_MIG_CICLO.count > 0) THEN       
    FOR i IN vtyLDC_MIG_CICLO.First .. vtyLDC_MIG_CICLO.Last LOOP 
         
      vtyLDC_MIG_CICLO_copia( vtyLDC_MIG_CICLO(i).CODICICL ) := vtyLDC_MIG_CICLO(i);
             
    end loop;  
   end if;
  
   
   vtyPERIFACT.delete;
   vtyPERIFACT_copia.delete;
    
   OPEN cuPERIFACT;
   FETCH cuPERIFACT BULK COLLECT INTO vtyPERIFACT;
   CLOSE cuPERIFACT;
    
    IF (vtyPERIFACT.count > 0) THEN       
    FOR i IN vtyPERIFACT.First .. vtyPERIFACT.Last LOOP 
         
      vtyPERIFACT_copia( vtyPERIFACT(i).pefallave ) := vtyPERIFACT(i);
             
    end loop;  
   end if;
    
   OPEN cuFactura;
   LOOP
      --
      -- Borrar tablas     tbl_datos.
      --
      tbl_datos.delete;
      FETCH cuFactura
      BULK COLLECT INTO TBL_DATOS
      LIMIT 1000;
      NUTOTALREGS := NUTOTALREGS + TBL_DATOS.COUNT;
      FOR nuindice IN 1 .. tbl_datos.COUNT LOOP
          BEGIN
           
           
           
           
           vcontLec := vcontLec + 1;
           nuFactura := tbl_datos(nuindice).FACTCODI;
           nuCicloHo := vtyLDC_MIG_CICLO_copia(tbl_datos(nuindice).Factcicl).CICLHOMO;
           nuperifact := vtyPERIFACT_copia(nuCicloho||substr(tbl_datos(nuindice).Factano,3)||tbl_datos(nuindice).Factmes).PEFACODI;
           
               INSERT INTO Factura
                        values(tbl_datos(nuindice).factcodi+nucomplementofa,tbl_datos(nuindice).factsusc+nucomplementosu,nuperifact,
                               tbl_datos(nuindice).GEO_LOCA_FATHER_ID,tbl_datos(nuindice).geograp_location_id, 0,tbl_datos(nuindice).factfege,'MIGRA',1,
                               decode (tbl_datos(nuindice).FACTPROG,'FGCC',6,123),66,tbl_datos(nuindice).factcodi+nucomplementofa,null,null,null,null, 
                               tbl_datos(nuindice).susciddi);
                               
               vcontIns := vcontIns + 1;
           EXCEPTION
               WHEN OTHERS THEN
                    BEGIN
                         NUERRORES := NUERRORES + 1;
                         PKLOG_MIGRACION.prInsLogMigra ( 183,183,2,vprograma||vcontIns,0,0,'Factura : '||nuFactura||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
                    END;
           END;
      END LOOP;
      COMMIT;
      EXIT WHEN cuFactura%NOTFOUND;
   END LOOP;
    -- Cierra CURSOR.
   IF (cuFactura%ISOPEN)
   THEN
      --{
      CLOSE cuFactura;
      --}
   END IF;
   COMMIT;
    --- Termina log
   PKLOG_MIGRACION.PRINSLOGMIGRA ( 183,183,3,VPROGRAMA,NUTOTALREGS,NUERRORES,'TERMINO PROCESO #regs: '||VCONTINS,'FIN',NULOGERROR);
  UPDATE migr_rango_procesos set raprfefi=sysdate,raprterm='T' where raprcodi=183 and raprbase=pbd and raprrain=numinicio and raprrafi=NUMFINAL;
  COMMIT;
  EXCEPTION
     WHEN OTHERS THEN
        BEGIN
           NUERRORES := NUERRORES + 1;
            PKLOG_MIGRACION.prInsLogMigra ( 183,183,2,vprograma||vcontIns,0,0,'Factura : '||nuFactura||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
        END;
END FACTURAmigr; 
/
