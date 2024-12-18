CREATE OR REPLACE procedure      NOTASCASTMIGR AS
/*******************************************************************
 PROGRAMA        :    NOTASCAST_C_OLS
 FECHA            :    27/09/2012
 AUTOR            :    OLSOFTWARE
 DESCRIPCION    :    Migra la informacion de las notas del ultimo castigo  generadas a los
                suscriptores
 HISTORIA DE MODIFICACIONES
 AUTOR       FECHA    DESCRIPCION
 *******************************************************************/
   vfecha_ini          DATE;
   vfecha_fin          DATE;
   vprograma           VARCHAR2 (100);
   verror              VARCHAR2 (4000);
   vcont               NUMBER;
   VAN NUMBER;
   vcontLec               NUMBER := 0;
   vcontIns               NUMBER := 0;
   sbDocumento            varchar2(20) := null;
   NNOTA NUMBER;
   CUENTEO NUMBER;
   
     CURSOR CUCASTIGADOS IS
          SELECT l.SESUNUSE sesunuse
                 FROM LDC_TEMP_SERVSUSC_SGE l,open.servsusc s
                 WHERE l.BASEDATO=4
                       AND l.SESUESFI=1
                       and s.sesunuse=l.sesunuse AND S.SESUESFN='C'
                     ORDER BY l.SESUNUSE;
                 
   cursor cufact (nsn number,dte date) is
          select distinct cucofact
                 from open.cargos,open.cuencobr
                 where cargnuse=nsn and
                       trunc(cargfecr)=trunc(dte) and
                       cargcaca in (51,2) and
                       cargcuco=cucocodi;

   cursor cucuco (fct number) is
          select cucocodi,cuconuse
                 from open.cuencobr
                 where cucofact=fct ;

   cursor cuNotas(cccu NUMBER)
       is
   SELECT CARGCACA,ROWID,
          1 NOTANUME,
          cargvalo,
          CARGNUSE    NOTASUSC,
          CARGSIGN      CARGSIGN,
          A.CARGFECR    NOTAFECO,
          CARGCUCO      CARGCUCO,
          A.CARGFECR    NOTAFECR,
          1             NOTAUSUA,
          'MIGRA CAST'    NOTATERM,
          70             NOTAPROG,
          'NOTA CASTIGO EN GASPLUS' NOTAOBSE,
          decode(a.CARGSIGN,'DB',70,71)     NOTACONS,
          NULL            NOTANUFI,
          NULL            NOTADOCU,
          NULL            NOTACONF,
          NULL            NOTAIDPR,
          CARGDOSO            NOTADOSO,
          'U'    NOTATINO,
          -1               NOTAFACT,
          NULL            NOTAPREF,
          NULL            NOTACOAE,
          NULL            NOTAFEEC,
          NULL             NOTAAPMO
        FROM open.CARGOS a 
        WHERE CARGcuco=cccu;

  -- DECLARACION DE TIPOS.
   --
   TYPE tipo_cu_datos IS TABLE OF cuNotas%ROWTYPE;
   -- DECLARACION DE TABLAS TIPOS.
   --
   tbl_datos      tipo_cu_datos := tipo_cu_datos ();
   nuLogError NUMBER;
   nuTotalRegs number := 0;
   nuErrores number := 0;
 
  
   CC NUMBER;
   TS open.GE_SUBSCRIBER.SUBSCRIBER_TYPE_ID%TYPE;
   IDS open.GE_SUBSCRIBER.IDENTIFICATION%TYPE;
   CLIE open.GE_SUBSCRIBER.SUBSCRIBER_ID%TYPE;
   SSS open.SUSCRIPC.SUSCCODI%TYPE;
   FUC DATE;
   VACA NUMBER;
   mens_bd varchar2(20);
    VOY number;
   SWCREA NUMBER;
   svr number;
BEGIN
  
     delete from log_migracion where lomiproc=214;
     commit;
     PKLOG_MIGRACION.prInsLogMigra (214,214,1,'NOTASCASTMIGR',0,0,'Inicia Proceso','INICIO',nuLogError);
     -- borra las notas de castigo de todos los usuarios
   DELETE FROM open.NOTAS WHERE NOTATINO='U';
   COMMIT;
   
   -- borra el detalle de los usuarios asociados a proyecto de castigo migracion
   delete from open.gc_prodprca where prpcprca=0;
   commit;
   
   -- borra el proyecto de castigo de migracion, el codigo 0
   delete from open.gc_proycast where prcacons=0;
   commit;
   -- INSERTA PROYECTO DE CASTIGO DE MIGRACION
   insert into open.gc_proycast (PRCACONS,PRCAFECR,PRCAOBSE,PRCAPRPC,PRCASAPC,PRCAPRCA,
                            PRCASACA,PRCAESTA,PRCASERV,PRCANOMB)
                   VALUES  (0,sysdate,'proyecto de castigo de usuarios migrados',
                            0,0,0,0,'T',7014,'MIGRACION');
   
   FOR U IN cucastigados LOOP
          VOY:=U.SESUNUSE;
       SELECT SEQ_GC_PRODPRCA_172041.NEXTVAL INTO CC FROM DUAL;
       -- BUSCA DATOS DE CONTRATO Y CLIENTE
       SELECT SUBSCRIBER_TYPE_ID,IDENTIFICATION,SUBSCRIBER_ID,SUSCCODI
                 INTO TS,IDS,CLIE,SSS
                 FROM GE_SUBSCRIBER,SUSCRIPC
                 WHERE SUSCRIPC.SUSCCODI=(SELECT SESUSUSC FROM SERVSUSC WHERE SESUNUSE=U.SESUNUSE) AND
                       SUBSCRIBER_ID=SUSCCLIE;
          -- BUSCA FECHA ULTIMO CASTIGO DE ESE USUARIO
          FUC:=NULL;
       BEGIN
               SELECT MAX(CARGFECR)
                      INTO FUC
                      FROM CARGOS
                      WHERE CARGNUSE=U.SESUNUSE AND
                            CARGCACA in (51,2);
       EXCEPTION
              WHEN OTHERS THEN
                   FUC:=NULL;
       END;
       VACA:=0;
       -- CALCULA LA SUMATORIA DE LAS NOTAS DEL ULTIMO CASTIGO, QUE ESO ES LA CARTERA CASTIGADA
       IF FUC IS NOT NULL THEN
          vaca:=0;
          -- INSERTA EN LA TABLA DE PRODUCTOS CASTIGADOS
          select sesuserv into svr from servsusc where sesunuse=u.sesunuse;
             INSERT INTO GC_PRODPRCA (PRPCCONS,PRPCPRCA,PRPCPOCA,PRPCTICL,PRPCIDCL,PRPCCLIE,PRPCSUSC,PRPCSERV,PRPCNUSE,PRPCSACA,PRPCFECA,PRPCTICA)
                            VALUES(CC,0,NULL,TS,IDS,CLIE,SSS,svr,U.SESUNUSE,0,FUC,1);
          -- VA A CREAR LAS NOTAS PARA ESE USUARIO
          IF FUC IS NOT NULL THEN
               FOR CF IN CUFACT(U.SESUNUSE,FUC) LOOP
                      SWCREA:=0;
                      FOR XCC IN CUCUCO(CF.CUCOFACT) LOOP
                     if xcc.cuconuse<>u.sesunuse then
                         SELECT SEQ_GC_PRODPRCA_172041.NEXTVAL INTO CC FROM DUAL;
                         select sesuserv into svr from servsusc where sesunuse=xcc.cuconuse;
                         SELECT COUNT(1) INTO CUENTEO FROM GC_PRODPRCA WHERE PRPCNUSE=XCC.CUCONUSE;
                         IF CUENTEO=0 THEN
                            INSERT INTO GC_PRODPRCA (PRPCCONS,PRPCPRCA,PRPCPOCA,PRPCTICL,PRPCIDCL,PRPCCLIE,PRPCSUSC,PRPCSERV,PRPCNUSE,PRPCSACA,PRPCFECA,PRPCTICA)
                                 VALUES(CC,0,NULL,TS,IDS,CLIE,SSS,svr,xcc.cucoNUSE,0,FUC,1);
                         END IF;
                     end if;
                     
                     FOR CNOTA IN cuNotas(XCC.CUCOCODI) LOOP
                         DECLARE
                                SUSC    NUMBER;
                                FACTUR  NUMBER;
                         BEGIN
                              vcontLec := vcontLec +1;
                              IF CNOTA.CARGCACA in (51,2) AND (CNOTA.CARGSIGN='DB' OR CNOTA.CARGSIGN='CR') THEN
                                 IF SWCREA=0 THEN
                                       SWCREA:=1;
                                       select sq_notas_notanume.nextval into nnota from dual;
                                    SELECT FACTSUSC INTO SUSC FROM FACTURA WHERE FACTCODI=CF.CUCOFACT;
                                    INSERT INTO notas (NOTANUME,NOTASUSC,NOTAFECO,NOTAFECR,NOTAUSUA,NOTATERM,NOTAPROG,NOTAOBSE,
                                          NOTACONS,NOTANUFI,NOTADOCU,NOTACONF,NOTAIDPR,NOTADOSO,NOTATINO,NOTAFACT,
                                          NOTAPREF,NOTACOAE,NOTAFEEC,NOTAAPMO)
                                          VALUES (NNOTA,SUSC,fuc,fuc,CNOTA.NOTAUSUA,CNOTA.NOTATERM,CNOTA.NOTAPROG,
                                              CNOTA.NOTAOBSE,CNOTA.NOTACONS,NULL,'PUN-0',NULL,NULL,'CR-'||to_char(nnota),CNOTA.NOTATINO,
                                              CF.CUCOFACT,CNOTA.NOTAPREF,CNOTA.NOTACOAE,fuc,CNOTA.NOTAAPMO);
                                 END IF;
                                 if cnota.cargsign='DB' then
                                    update GC_PRODPRCA set PRPCSACA=-cnota.cargvalo where prpcnuse=u.sesunuse;
                                 else
                                    update GC_PRODPRCA set PRPCSACA=-cnota.cargvalo where prpcnuse=u.sesunuse;
                                 end if;
                                 update cargos set CARGDOSO='CR-'||TO_CHAR(NNOTA),cargcodo=nnota,cargtipr='P',cargprog=70 where rowid=cnota.rowid;
                                 COMMIT;
                              END IF;
                              nuTotalRegs := nuTotalRegs + 1;
                         EXCEPTION
                              WHEN OTHERS THEN
                                   nuErrores := nuErrores + 1;
                                   PKLOG_MIGRACION.prInsLogMigra (214,214,2,'NOTASCAST_C_OLS',0,0,'Error: '||sqlerrm,to_char(sqlcode),nuLogError);
                                   exit;
                         END;
                     END LOOP;
                 END LOOP;
             END LOOP;
          END IF;
       end if;
   END LOOP;

 declare
  cursor nt is
         SELECT  notanume, NOTATINO
                 FROM    open.notas
                 WHERE notatino='U'
        minus
        SELECT  notanume, NOTATINO
                FROM    open.cargos, open.notas
                WHERE   notanume = cargcodo AND NOTATINO='U';
  cursor ca is
   SELECT  prpcnuse Producto,
   prpcprca Proyecto, prpcsaca Saldo_Castigado_Proyecto,
   sum(decode(cargsign,'DB',-cargvalo,'CR',cargvalo)) Saldo_Castigado_Notas
   FROM    open.gc_prodprca, open.notas, open.cargos
   WHERE   prpcsusc = notasusc
        AND notanume = cargcodo
        AND notaprog = cargprog
        AND notatino = 'U'
        AND notadocu = 'PUN-'||prpcprca and cargnuse=prpcnuse
GROUP BY prpcnuse, prpcprca, prpcsaca;
begin
   FOR N IN NT LOOP
       DELETE FROM open.NOTAS WHERE NOTANUME=N.NOTANUME;
       COMMIT;
   END LOOP;
   for c in ca loop
       update open.gc_prodprca set prpcsaca=c.saldo_castigado_notas where prpcnuse=c.producto and prpcprca=c.proyecto;
   end loop;
end;


   DECLARE
       VC NUMBER;
       NC NUMBER;
   BEGIN
          SELECT COUNT(DISTINCT PRPCNUSE),SUM(PRPCSACA) INTO NC,VC FROM GC_PRODPRCA WHERE PRPCPRCA=0;
          UPDATE open.gc_proycast
                 SET PRCAPRPC=NC,
                  PRCASAPC=VC,
                  PRCAPRCA=NC,
                  PRCASACA=VC
              WHERE PRCACONS=0;
   END;

   COMMIT;

   VAN:=0;
   COMMIT;
   -- Termina Log
   PKLOG_MIGRACION.prInsLogMigra (214,214,3,'NOTASCAST_C_OLS',nuTotalRegs,nuErrores,'TERMINO PROCESO #regs: '||nuTotalRegs,'FIN',nuLogError);
EXCEPTION
   WHEN OTHERS
   THEN
      PKLOG_MIGRACION.prInsLogMigra (214,214,2,'NOTASCAST_OLS SE PARTIO EN '||MENS_BD||' USUARIO '||TO_CHAR(VOY),0,0,'Error: '||sqlerrm,to_char(sqlcode),nuLogError);
END NOTASCASTMIGR; 
/
