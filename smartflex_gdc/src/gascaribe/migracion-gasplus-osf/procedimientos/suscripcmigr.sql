CREATE OR REPLACE PROCEDURE "SUSCRIPCMIGR"(NUMINICIO number,
                                           numFinal  number,
                                           pbd       number) as
  /*******************************************************************
  PROGRAMA        :    SUSCRIPCmigr
  FECHA            :    14/05/2014
  AUTOR            :    VICTOR HUGO MUNIVE ROCA
  DESCRIPCION    :    Migra la informacion de Suscripc a SUSCRIPC
  HISTORIA DE MODIFICACIONES
  AUTOR       FECHA    DESCRIPCION
  *******************************************************************/
  nuComplementoPR number;
  nuComplementoSU number;
  nuComplementoFA number;
  nuComplementoCU number;
  nuComplementoDI number;
  nuErrorCode     NUMBER;
  sbErrorMessage  VARCHAR2(4000);
  nusubscriber_id Ge_Subscriber.subscriber_id%TYPE;
  sbNombre        Ge_Subscriber.SUBSCRIBER_NAME%type;
  sbApellido1     Ge_Subscriber.SUBS_LAST_NAME%type;
  sbApellido2     Ge_Subscriber.SUBS_SECOND_LAST_NAME%type;
  nuDocumento     number(20) := 0;
  vfecha_ini      DATE;
  vfecha_fin      DATE;
  vprograma       VARCHAR2(100);
  vcontLec        NUMBER := 0;
  vcontIns        NUMBER := 0;
  VERROR          VARCHAR2(4000);
  NUNUMERO        NUMBER := 0;
  nuCliente       number := 0;
  -- Cursor con los datos de origen
  cursor cuSuscripc is
    SELECT /*+ PARALLEL */
     A.SUSCCODI + nuComplementoSU SUSCCODI,
     A.SUSCNICE,
     DECODE(B.CICLHOMO, NULL, -1, B.CICLHOMO) CICLHOMO,
     1 SUSCTIID,
     a.SUSCSAFA,
     --           C.ADDRESS_ID  PREDHOMO,
     -- 19/09/2014 se indica que todos los usuarios van a migrar como ventanilla y posteriormente se va a cargar un archivo de recaudo
     'VT' SUSCDEAU,
     f.banchomo SUSCBANC,
     h.subahomo SUSCSUBA,
     A.SUSCCUEN,
     g.codigo_cliente PADRE,
     A.SUSCEFCE,
     A.SUSCMAIL
      FROM ldc_temp_suscripc_sge A,
           LDC_MIG_CICLO         B,
           ldc_clie_susc         g,
           ldc_mig_sucubanc      h,
           ldc_mig_banco         F,
           GE_SUBSCRIBER         C
     WHERE a.SUSCCICL = b.CODICICL
       AND a.basedato = B.DATABASE
       and g.susccodi = a.susccodi
       AND a.basedato = g.basedato
       AND a.suscbanc = f.codibanc(+)
       AND a.basedato = f.basedato(+)
       AND h.banccodi(+) = a.suscbanc
       AND h.subacodi(+) = a.suscsuba
       AND h.basedato(+) = a.basedato
       AND a.susccodi >= numinicio
       AND a. susccodi < numfinal
       AND G.CODIGO_CLIENTE = C.SUBSCRIBER_ID
       AND g.basedato = pbd;

  Cursor cudir(nususccodi Number) Is
    Select nvl(predhomo, 1)
      From ldc_mig_direccion a, ldc_temp_servsusc_sge b
     Where a.predcodi = b.sesupred
       And b.sesususc = nususccodi - nucomplementosu
       And b.basedato = pbd
     Order By b.sesuserv;

  -- DECLARACION DE TIPOS.
  --
  TYPE tipo_cu_datos IS TABLE OF cuSuscripc%ROWTYPE;
  -- DECLARACION DE TABLAS TIPOS.
  --
  tbl_datos tipo_cu_datos := tipo_cu_datos();
  --- Control de errores
  nuLogError  NUMBER;
  NUTOTALREGS NUMBER := 0;
  NUERRORES   NUMBER := 0;
  nuAddressid number := 0;
BEGIN
  update migr_rango_procesos
     set raprfein = sysdate, RAPRTERM = 'P'
   where raprcodi = 156
     and raprbase = pbd
     and raprrain = numinicio
     and raprrafi = NUMFINAL;
  commit;

  pkg_constantes.COMPLEMENTO(pbd,
                             nuComplementoPR,
                             nuComplementoSU,
                             nuComplementoFA,
                             nuComplementoCU,
                             nuComplementoDI);

  VPROGRAMA  := 'SUSCRIPCmigr';
  vfecha_ini := SYSDATE;
  -- Inserta registro de inicio en el log
  PKLOG_MIGRACION.prInsLogMigra(156,
                                156,
                                1,
                                vprograma,
                                0,
                                0,
                                'Inicia Proceso',
                                'INICIO',
                                nuLogError);
  -- Extraer los datos
  OPEN cuSuscripc;
  LOOP
    --
    -- Borrar tablas     tbl_datos.
    --
    tbl_datos.delete;
    FETCH cuSuscripc BULK COLLECT
      INTO tbl_datos LIMIT 1000;
    NUTOTALREGS := NUTOTALREGS + TBL_DATOS.COUNT;
    FOR nuindice IN 1 .. tbl_datos.COUNT LOOP
      BEGIN
        NUERRORCODE    := NULL;
        SBERRORMESSAGE := NULL;
        nuAddressid    := null;
      
        open cudir(tbl_datos(nuindice).susccodi);
        fetch cudir
          INTO nuAddressid;
        close cudir;
      
        GSI_MIG_RegistraContrato(tbl_datos(nuindice).susccodi, -- Codigo de la suscripci¿n
                                 tbl_datos(nuindice).PADRE, -- Codigo del cliente GE_SUBSCRIBER
                                 -1, -- Tipo de Suscripcion
                                 'PC', -- Tipo de moneda
                                 tbl_datos(nuindice).CICLHOMO, -- Ciclo de facturacion CICLO
                                 tbl_datos(nuindice).suscbanc, -- Codigo del Banco BANCO
                                 tbl_datos(nuindice).suscsuba, -- Codigo de la sucursal bancaria SUCUBANC
                                 tbl_datos(nuindice).SUSCCUEN, -- Cuenta Bancaria
                                 1, -- Tipo de cuenta bancaria TICUBANC
                                 nuAddressid, -- ID de la dir de cobro AB_ADDRESS
                                 null, -- Fecha de expiracion de la tarjeta de credito
                                 1, -- Tipo de tarjeta
                                 null, -- Centro de Costos
                                 tbl_datos(nuindice).SUSCDEAU, -- DEBITO AUTOMATICO
                                 tbl_datos(nuindice).SUSCMAIL, -- Direccion electronica de cobro
                                 tbl_datos(nuindice).susctiid, -- Tipo de identificacion del dueno de la tarjeta GE_IDENTIFICA_TYPE
                                 tbl_datos(nuindice).suscnice, -- Identificacion del dueno de la tarjeta
                                 tbl_datos(nuindice).SUSCMAIL, -- Email del Contrato
                                 NULL, -- Entidad de Cobro ENTICOBR
                                 -1, -- Programa de Cartera PROGCART
                                 tbl_datos(nuindice).suscsafa, -- Saldo a favor
                                 null, --- Mezcla impresion de facturas
                                 null,
                                 null,
                                 tbl_datos(nuindice).SUSCEFCE,
                                 nuErrorCode, -- Codigo del error
                                 sbErrorMessage -- Mensaje de error
                                 );
        vcontLec := vcontLec + 1;
        if nuErrorCode is not null then
          NUERRORES := NUERRORES + 1;
          PKLOG_MIGRACION.prInsLogMigra(156,
                                        156,
                                        2,
                                        vprograma || vcontIns,
                                        nucliente,
                                        0,
                                        'Cliente : ' || nuCliente ||
                                        ' - Error: ' || sbErrorMessage,
                                        to_char(nuErrorCode),
                                        nuLogError);
        else
          vcontIns := vcontIns + 1;
        end if;
      EXCEPTION
        WHEN OTHERS THEN
          BEGIN
            NUERRORES := NUERRORES + 1;
            PKLOG_MIGRACION.prInsLogMigra(156,
                                          156,
                                          2,
                                          vprograma || vcontIns,
                                          nucliente,
                                          0,
                                          'Cliente : ' || nuCliente ||
                                          ' - Error: ' || sqlerrm,
                                          to_char(sqlcode),
                                          nuLogError);
          END;
      END;
    END LOOP;
    COMMIT;
    EXIT WHEN cuSuscripc%NOTFOUND;
  END LOOP;
  -- Cierra CURSOR.
  IF (cuSuscripc%ISOPEN) THEN
    --{
    CLOSE cuSuscripc;
    --}
  END IF;

  COMMIT;
  --- Termina log
  update migr_rango_procesos
     set raprfefi = sysdate, raprterm = 'T'
   where raprcodi = 156
     and raprbase = pbd
     and raprrain = numinicio
     and raprrafi = NUMFINAL;
  commit;
  PKLOG_MIGRACION.PRINSLOGMIGRA(156,
                                156,
                                3,
                                VPROGRAMA,
                                NUTOTALREGS,
                                NUERRORES,
                                'TERMINO PROCESO #regs: ' || VCONTINS,
                                'FIN',
                                NULOGERROR);
EXCEPTION
  WHEN OTHERS THEN
    BEGIN
      NUERRORES := NUERRORES + 1;
      PKLOG_MIGRACION.prInsLogMigra(156,
                                    156,
                                    2,
                                    vprograma || vcontIns,
                                    0,
                                    0,
                                    'Cliente : ' || nuCliente ||
                                    ' - Error: ' || sqlerrm,
                                    to_char(sqlcode),
                                    nuLogError);
    END;
END SUSCRIPCmigr; 
/
