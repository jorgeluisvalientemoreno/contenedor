CREATE OR REPLACE Procedure pr_ldc_osf_sesucier(numinicio   Number,
                                                numfinal    Number,
                                                inubasedato Number) As

  nucomplementopr Number;
  nucomplementosu Number;
  nucomplementofa Number;
  nucomplementocu Number;
  nucomplementodi Number;

  Cursor cusesucier Is
    Select /*+ parallel */
     *
      From migra.ldc_temp_sesucier_sge s
     Where s.basedato = inubasedato
       And s.susc >= numinicio
       And s.susc < numfinal;

  Type tipo_cu_datos Is Table Of cusesucier%Rowtype;

  tbl_datos tipo_cu_datos := tipo_cu_datos();

  /*CURSOR cuServicio(nuServ number)
  IS
       SELECT *
       FROM LDC_MIG_SERVICIO
       WHERE CODISERV = nuServ; /*SERV*/

  --rgServicio   cuServicio%rowtype;

  Cursor cusubcategoria(nucate Number, nusuca Number) Is
    Select *
      From ldc_mig_subcateg
     Where codicate = nucate
       And codisuca = nusuca;

  rgsubcategoria cusubcategoria%Rowtype;

  Cursor cuestadoservicio(nueste Number, nuesfi Number) Is
    Select *
      From ldc_estados_serv_homo
     Where estado_tecnico = nueste /*ESTE*/
       And estado_financi = nuesfi; /*ESFI*/

  rgestadoservicio cuestadoservicio%Rowtype;

  Cursor culocalidad(nudepr Number, nulopr Number) Is
    Select *
      From ldc_mig_localidad
     Where codidepa = nudepr /*DEPR*/
       And codiloca = nulopr; /*LOPR*/

  rglocalidad culocalidad%Rowtype;

  Cursor cuproduct(nuproduct Number) Is
    Select * From pr_product Where product_id = nuproduct;

  rgproducto    cuproduct%Rowtype;
  rgprodubrilla cuproduct%Rowtype;

  Cursor cuaddress(nuaddressid Number) Is
    Select s.segments_id,
           a.address_parsed,
           a.is_urban,
           b.zone,
           b.sector,
           p.premise_type_id,
           p.number_division,
           p.premise,
           p.block_side,
           b.block_id,
           p.zip_code_id,
           p.premise_id,
           g.geo_loca_father_id,
           g.geograp_location_id,
           s.operating_sector_id,
           a.neighborthood_id
      From ab_address         a,
           ge_geogra_location g,
           ab_segments        s,
           ab_premise         p,
           ab_block           b
     Where a.geograp_location_id = g.geograp_location_id
       And a.segment_id = s.segments_id
       And a.estate_number = p.premise_id
       And b.block_id = p.block_id
       And a.address_id = nuaddressid;

  rgaddress cuaddress%Rowtype;

  Cursor cususcripcion(nusuccodi Number) Is
    Select * From suscripc Where susccodi = nusuccodi;

  rgsuscripcion cususcripcion%Rowtype;

  Cursor cuservsuscrito(nusesunuse Number) Is
    Select * From servsusc Where sesunuse = nusesunuse;

  rgservicio cuservsuscrito%Rowtype;

  Cursor cucliente(nucliente Number) Is
    Select * From ge_subscriber Where subscriber_id = nucliente;

  rgcliente cucliente%Rowtype;

  Cursor cuconssesu(nucosssesu Number) Is
    Select * From conssesu Where cosssesu = nucosssesu;

  rgconssesu cuconssesu%Rowtype;

  nuatencion  mo_packages.package_id%Type;
  nupolicyid  ld_policy.policy_id%Type;
  nulogerror  Number;
  nutotalregs Number := 0;
  nuerrores   Number := 0;
  verror      Varchar2(4000);
  vcont       Number;
  nui         Number;

  nu_deuda_corriente_no_vencida Number;
  nu_deuda_corriente_vencida    Number;
  nu_deuda_no_corriente         Number;
  nuvalorreclamo                cuencobr.cucovare%Type;
  nuvalorpagar                  cuencobr.cucovrap%Type;

  dtfechaedad                Date;
  sbflagedad                 Varchar2(2);
  nucuotassaldo              Number;
  nuvalorcastigado           Number;
  nudeudadiferidacorriente   Number;
  nudeudadiferidanocorriente Number;

  nusaldopendiente Number;
  nudiferido       Number;

  nuedad Number;

  -- ge_subscriber

Begin

  pklog_migracion.prinslogmigra(4882,
                                4882,
                                1,
                                'PR_LDC_OSF_SESUCIER_C',
                                nutotalregs,
                                nuerrores,
                                'INICIA PROCESO #regs: ' || nutotalregs,
                                'FIN',
                                nulogerror);
  Update migr_rango_procesos
     Set raprterm = 'P',
         raprfein = Sysdate
   Where raprbase = inubasedato
     And raprrain = numinicio
     And raprrafi = numfinal
     And raprcodi = 4882;
  Commit;

  pkg_constantes.complemento(inubasedato,
                             nucomplementopr,
                             nucomplementosu,
                             nucomplementofa,
                             nucomplementocu,
                             nucomplementodi);

  Open cusesucier;

  Loop
  
    tbl_datos.delete;
  
    Fetch cusesucier Bulk Collect
      Into tbl_datos Limit 1000;
  
    For nui In 1 .. tbl_datos.count Loop
    
      Begin
      
        Open cuproduct(tbl_datos(nui).nuse + nucomplementopr);
        Fetch cuproduct
          Into rgproducto;
        Close cuproduct;
      
        Open cususcripcion(tbl_datos(nui).susc + nucomplementosu);
        Fetch cususcripcion
          Into rgsuscripcion;
        Close cususcripcion;
      
        Open cuaddress(rgproducto.address_id);
        Fetch cuaddress
          Into rgaddress;
        Close cuaddress;
      
        Open cuservsuscrito(tbl_datos(nui).nuse + nucomplementopr);
        Fetch cuservsuscrito
          Into rgservicio;
        Close cuservsuscrito;
      
        Open cucliente(rgsuscripcion.suscclie);
        Fetch cucliente
          Into rgcliente;
        Close cucliente;
      
        /*OPEN cuServicio(tbl_datos(nuI).SERV);
        FETCH cuServicio INTO rgServicio;
        CLOSE cuServicio; */
      
        Open cusubcategoria(tbl_datos(nui).cate, tbl_datos(nui).suca);
        Fetch cusubcategoria
          Into rgsubcategoria;
        Close cusubcategoria;
      
        Open cuestadoservicio(tbl_datos(nui).este, tbl_datos(nui).esfi);
        Fetch cuestadoservicio
          Into rgestadoservicio;
        Close cuestadoservicio;
      
        Open culocalidad(tbl_datos(nui).depr, tbl_datos(nui).lopr);
        Fetch culocalidad
          Into rglocalidad;
        Close culocalidad;
      
        --nu_deuda_corriente_no_vencida := tbl_datos(nuI).SAPE-gc_bodebtmanagement.fnugetexpirdebtbyprod(rgProducto.product_id);
        --nu_deuda_corriente_vencida := gc_bodebtmanagement.fnugetexpirdebtbyprod(rgProducto.product_id);
        -- nu_deuda_no_corriente := gc_bodebtmanagement.fnugetdefdebtbyprod(rgProducto.product_id);
      
        nu_deuda_corriente_no_vencida := nvl(tbl_datos(nui).valor_vencido,
                                             0);
        nu_deuda_corriente_vencida    := nvl(tbl_datos(nui).presente_mes,
                                             0);
      
        nuvalorcastigado := 0;
      
        Begin
          Select nvl(Sum(cucovare), 0), nvl(Sum(cucovrap), 0)
            Into nuvalorreclamo, nuvalorpagar
            From cuencobr
           Where cuconuse = tbl_datos(nui).nuse + +nucomplementopr;
        Exception
          When no_data_found Then
            nuvalorreclamo := 0;
            nuvalorpagar   := 0;
        End;
      
        /*
        ldc_edad_mes
        ldc_calculaedadmoraprod
        */
      
        --dtFechaEdad := ldc_calculaedadmoraprod(rgProducto.product_id);
      
        /*IF dtFechaEdad = to_date('01/01/1800','dd/mm/yyyy') THEN
           nuedad := -2;
        ELS*/
        /*IF dtFechaEdad = to_date('01/01/1900','dd/mm/yyyy') THEN
           sbFlagEdad := 'S';
        ELSE
           sbFlagEdad := 'N';
        END IF; */
      
        If tbl_datos(nui).edad = 0 Then
          sbflagedad := 'S';
        Else
          sbflagedad := 'N';
        End If;
      
        Select Count(1)
          Into nucuotassaldo
          From cuencobr
         Where cuconuse = tbl_datos(nui).nuse + nucomplementopr
           And cucosacu > 0;
      
        nudeudadiferidacorriente   := nvl(tbl_datos(nui).diferido_corriente,
                                          0);
        nudeudadiferidanocorriente := nvl(tbl_datos(nui)
                                          .diferido_no_corriente,
                                          0);
      
        nusaldopendiente := tbl_datos(nui).sape;
        nudiferido       := nudeudadiferidacorriente;
      
        Select decode(tbl_datos(nui).edad,
                      0,
                      0,
                      1,
                      0,
                      2,
                      0,
                      3,
                      0,
                      (tbl_datos(nui).edad - 3) * 30)
          Into nuedad
          From dual;
      
        -- Se crea el cierre para el producto de gas
        Insert /*+ APPEND */
        Into ldc_osf_sesucier
          (tipo_producto,
           nuano,
           numes,
           cliente,
           contrato,
           producto,
           ciclo,
           sesusape,
           saldo_favor,
           departamento,
           localidad,
           sector,
           estado_tecnico,
           estado_financiero,
           estado_corte,
           categoria,
           subcategoria,
           nombres,
           apellido,
           segundo_apellido,
           edad,
           deuda_corriente_no_vencida,
           deuda_corriente_vencida,
           deuda_no_corriente,
           deuda_diferida_corriente,
           deuda_diferida_no_corriente,
           barrio,
           consumo,
           codigo_predio,
           manzana,
           lado_manzana,
           numero_predio,
           numero_mejora,
           secuencia_tipo_predio,
           segmento_predio,
           consecutivo_zona_postal,
           tipo_consumo,
           flag_valor_reclamo,
           valor_reclamo,
           flag_pago_no_abo,
           valor_pago_no_abonado,
           flag_edad_0_mes,
           nro_ctas_con_saldo,
           valor_castigado,
           sector_catastral,
           zona_catastral,
           ubicacion,
           direccion_producto)
        
        Values
          (rgproducto.product_type_id,
           tbl_datos(nui).ano,
           tbl_datos(nui).mes,
           rgsuscripcion.suscclie,
           tbl_datos(nui).susc + nucomplementosu,
           tbl_datos(nui).nuse + nucomplementopr,
           rgsuscripcion.susccicl,
           nu_deuda_corriente_no_vencida + nu_deuda_corriente_vencida,
           tbl_datos(nui).safa,
           rglocalidad.depahomo,
           rglocalidad.colohomo,
           rgaddress.operating_sector_id,
           rgestadoservicio.osf_estado_produc,
           rgestadoservicio.osf_estado_financr,
           rgestadoservicio.osf_estado_corte,
           rgsubcategoria.catehomo,
           rgsubcategoria.estrhomo,
           rgcliente.subscriber_name,
           rgcliente.subs_last_name,
           rgcliente.subs_second_last_name,
           nuedad,
           nu_deuda_corriente_no_vencida,
           nu_deuda_corriente_vencida,
           nvl(tbl_datos(nui).diferido_corriente, 0) +
           nvl(tbl_datos(nui).diferido_no_corriente, 0),
           nvl(tbl_datos(nui).diferido_corriente, 0),
           nvl(tbl_datos(nui).diferido_no_corriente, 0),
           rgaddress.neighborthood_id,
           tbl_datos(nui).consumo,
           rgaddress.premise_id,
           rgaddress.block_id,
           rgaddress.block_side,
           rgaddress.premise,
           rgaddress.number_division,
           rgaddress.premise_type_id,
           rgaddress.segments_id,
           rgaddress.zip_code_id,
           1,
           decode(nuvalorreclamo, 0, 'N', 'S'),
           nuvalorreclamo,
           decode(nuvalorpagar, 0, 'N', 'S'),
           nuvalorpagar,
           sbflagedad,
           tbl_datos(nui).secicusa,
           nuvalorcastigado,
           rgaddress.sector,
           rgaddress.zone,
           rgaddress.is_urban,
           rgaddress.address_parsed);
      
      Exception
        When Others Then
          Begin
            verror := 'Error: ' || tbl_datos(nui).nuse || ' - ' || Sqlerrm;
          
            nuerrores := nuerrores + 1;
            --dbms_output.put_Line('Error: '||sqlerrm);
            pklog_migracion.prinslogmigra(505,
                                          505,
                                          2,
                                          'PR_LDC_OSF_SESUCIER_C',
                                          0,
                                          0,
                                          'Error: ' || verror,
                                          to_char(Sqlcode),
                                          nulogerror);
          End;
      End;
    
    End Loop; -- Fin for cuSesucier
  
    Commit;
    Exit When cusesucier%Notfound;
  
  End Loop; -- Fin CURSOR cuSesucier

  If (cusesucier%Isopen) Then
    Close cusesucier;
  End If;

  pklog_migracion.prinslogmigra(4882,
                                4882,
                                3,
                                'PR_LDC_OSF_SESUCIER_C',
                                nutotalregs,
                                nuerrores,
                                'TERMINO PROCESO #regs: ' || nutotalregs,
                                'FIN',
                                nulogerror);
  Update migr_rango_procesos
     Set raprterm = 'T',
         raprfefi = Sysdate
   Where raprbase = inubasedato
     And raprrain = numinicio
     And raprrafi = numfinal
     And raprcodi = 4882;
  Commit;

Exception
  When Others Then
    --dbms_output.put_Line('Error: '||sqlerrm);
    pklog_migracion.prinslogmigra(505,
                                  505,
                                  2,
                                  'PR_LDC_OSF_SESUCIER_C',
                                  0,
                                  0,
                                  'Error: ' || Sqlerrm,
                                  to_char(Sqlcode),
                                  nulogerror);
    If (cusesucier%Isopen) Then
      Close cusesucier;
    End If;
  
End pr_ldc_osf_sesucier; 
/
