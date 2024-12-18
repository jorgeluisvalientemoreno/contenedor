CREATE OR REPLACE PROCEDURE      CARGOSmigr ( nuDataBase number, nuAno number, nuHilo number ) AS
  /*******************************************************************
 PROGRAMA    	    :   CARGOSmigr
 FECHA            :    16/05/2014
 AUTOR            :    VICTOR HUGO MUNIVE ROCA
 DESCRIPCION        :    Migra la informacion de Cargos a Facturar a CARGOS
 HISTORIA DE MODIFICACIONES
 AUTOR       FECHA    DESCRIPCION
 *******************************************************************/
   nuComplementoPR   number;
   nuComplementoSU   number;
   nuComplementoFA   number;
   nuComplementoCU   number;
   nuComplementoDI  number;
    vprograma              VARCHAR2 (100);
    vcontIns            NUMBER := 0;
    nuContMes           number := 0;
    nuCuenta            number := null;
    nuConcepto          number := null;
    nuIndex number;
    cnuLimite       CONSTANT number := 1000;
    verror            VARCHAR2 (2000);
    dtIndex             date ;
    dtfechaini          date ;
    nuLogError number;
    nuLogErrorPro number;
    nuProceso   number := 426;        
    cursor cuCargos (
                    inuAno in number,
                    inuDataBase in number,
                    inuHilo in number)       is
      SELECT    b.cargcuco+nucomplementocu cargcuco,
                B.CARGNUSE+nuComplementopr CARGNUSE,
                d.conchomo    cargconc,
                e.CACAHOMO    cargcaca,
                B.CARGSIGN    CARGSIGN,
                f.PEFAHOMO    CARGPEFA,
                b.CARGVALO    CARGVALO,
                b.cargdoso    cargdoso,
                CASE
                    WHEN CARGSIGN='PA' THEN
                         NVL(CARGCODO,0)
                    when carGsign='SA' THEN
                         NVL(CARGCODO,0)
                    ELSE
                         0
                    END cargcodo,
                343             cargusua,
                decode(cargsign,'PA','P','A')   CARGTIPR,
                b.cargunid    cargunid,
                b.cargfecr    cargfecr,
                161            CARGPROG,
                NULL            cargcoll,
                f.PEFAHOMO    CARGPECO,
                NULL    cargtico,
                NULL    cargvabl,
                -1 Cargtaco
                From  Ldc_Temp_Cargos_SGE B,
                      Ldc_Mig_Concepto D,
                      Ldc_Mig_Perifact F,
                      Ldc_Mig_Causcarg E
                WHERE B.CARGANO = inuAno
                      AND B.CARGMES = inuHilo
                      AND B.CARGCUCO > 0
                      AND d.CODICONCE = b.cargconc
                      AND e.CODICACA = b.cargcaca
                      AND f.CODIANO = B.CARGANO
                      AND f.CODIMES  = B.CARGMES
                      AND f.CODICICL = B.CARGCICL
                      AND f.CODIPEFA  = B.CARGPEFA
                      AND F.DATABASE = inuDataBase
                      and  D.database = inuDataBase
                      And B.Basedato = inuDataBase;
    -- DECLARACION DE TIPOS.
    TYPE tipo_cu_datos IS TABLE OF cuCargos%ROWTYPE;
    -- DECLARACION DE TABLAS TIPOS.
    tbl_datos      tipo_cu_datos := tipo_cu_datos ();
    PROCEDURE procesa (tbTabla IN OUT tipo_cu_datos) IS
        nuLogError number;
    BEGIN
        for indice in  tbTabla.first..tbTabla.last loop -- Cargos
            begin
                nuCuenta:= tbTabla(indice).CARGCUCO;
                nuConcepto := tbTabla(indice).cargconc;
                tbTabla(indice).Cargtaco := null;
                INSERT /*+ APPEND*/ INTO cargos VALUES tbTabla (indice);
            EXCEPTION WHEN OTHERS THEN
                 verror := 'Error: Cuenta['||nuCuenta||'] Concepto['||nuConcepto||'] '||SQLCODE ||'-'|| SQLERRM;
                PKLOG_MIGRACION.prInsLogMigra ( nuProceso,nuProceso,2,vprograma,nuCuenta,0,verror,to_char(sqlcode),nuLogErrorPro);
            END;
        END loop;
    END procesa;
BEGIN
   -- Insertar datos en los los log de migraci?n
   vprograma := 'CARGOS';
   PKLOG_MIGRACION.prInsLogMigra ( nuProceso,nuProceso,1,vprograma,0,0,'A¿o/Base/Hilo: '
                                   ||nuAno||'/'||nuDatabase||'/'||nuHilo,'INICIO',nuLogError);
    
    pkg_constantes.COMPLEMENTO(nuDataBase,nuComplementoPR,nuComplementoSU,nuComplementoFA,nuComplementoCU,nuComplementoDI);   
    vcontIns := 0;
    nuContMes := 0;
    -- Cargar Registros
    OPEN  cuCargos(nuAno, nuDataBase, nuHilo);
    LOOP
        FETCH cuCargos
        BULK COLLECT INTO tbl_datos
        LIMIT cnuLimite;
        -- Se sale cuando no haya mas cargos por procesar
        exit when (cuCargos%NOTFOUND is null) OR (tbl_datos.first IS null);
        nuIndex := tbl_datos.first;
        -- Procesa cargos
        if tbl_datos.count > 0 then
            procesa(tbl_datos);
        END if;
        -- Actualiza cantidad de registrosp procesados
        vcontIns := vcontIns + tbl_datos.count;
        PKLOG_MIGRACION.prUpdLogMigra(nuLogError,sysdate,vcontIns);
        commit;
        -- Elimina colecci?n para procesar siguiente colecci?n
        tbl_datos.delete;
    END loop;
    CLOSE cuCargos;
    PKLOG_MIGRACION.prUpdLogMigra(nuLogError,sysdate,vcontIns);
    PKLOG_MIGRACION.prInsLogMigra ( nuProceso,nuProceso,3,vprograma||' - TERMINO ->'||vcontIns,0,0,'A¿o/Base/Hilo: '
                                   ||nuAno||'/'||nuDatabase||'/'||nuHilo,to_char(sqlcode),nuLogError);
    UPDATE trackmigrcargos SET ESTADO='T' WHERE ANO=NUANO AND MES=NUHILO AND BD=NUDATABASE;
    commit;
EXCEPTION
   WHEN OTHERS THEN
    PKLOG_MIGRACION.prInsLogMigra ( nuProceso,nuProceso,2,vprograma,0,0,sqlerrm,to_char(sqlcode),nuLogError);
END CARGOSmigr; 
/
