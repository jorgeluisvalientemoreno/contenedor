CREATE OR REPLACE PACKAGE adm_person.ldc_pkgrutcontcam AS
/**************************************************************************
        Autor       : Jennifer Gutierrez / OLsoftware
        Fecha       : 2021-04-21
        Ticket      : 596
        Descripci��n : Paquete que contiene dos procedimientos para seleccionar las facturas emitidas
                      de los ciclos para el año de acuerdo a los parametros de entrada.

        Parámetros Entrada

    	sbMacrociclo: Identificador del macrociclo a procesar. Lista de valores.
        sbAnio: Identificador del año a procesar
     	sbMes: Identificador del mes a procesar
    	nuNumeroMeses de meses a buscar: Cantidad de meses hacia atrás que el proceso buscará los cambios de ruta


        Valor de salida
        nuOk        0- Exito, -1 Error
        sbError     mensaje de error

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
        26/06/2024   Adrianavg   OSF-2883: Migrar del esquema OPEN al esquema ADM_PERSON
   ***************************************************************************/
PROCEDURE LDC_PRGENERATEDATA(nuMacrociclo in number,
                             nuAnio  in number,
                             nuMes   in number,
                             nuNumeroMeses in number,
                             sbmensa OUT VARCHAR2,
                             error   OUT NUMBER,
                             nutsess   in  NUMBER,
                             sbparuser in VARCHAR2);
PROCEDURE PROCESS;
END LDC_PKGRUTCONTCAM;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_PKGRUTCONTCAM AS
/**************************************************************************
        Autor       : Jennifer Gutierrez / OLsoftware
        Fecha       : 2021-04-21
        Ticket      : 596
        Descripci��n : Paquete que contiene dos procedimientos para seleccionar las facturas emitidas
                      de los ciclos para el a��o de acuerdo a los parametros de entrada.


        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/
  PROCEDURE LDC_PRGENERATEDATA(nuMacrociclo in number,
                               nuAnio  in number,
                               nuMes   in number,
                               nuNumeroMeses in number,
                               sbmensa OUT VARCHAR2,
                               error   OUT NUMBER,
                               nutsess   in  NUMBER,
                               sbparuser in VARCHAR2) AS
/**************************************************************************
        Autor       : Jennifer Gutierrez / OLsoftware
        Fecha       : 2021-04-21
        Ticket      : 596
        Descripci��n : LDC_PRGENERATEDATA para seleccionar las facturas emitidas
                      de los ciclos para el a��o de acuerdo a los parametros de entrada.

        Par��metros Entrada

    	sbMacrociclo: Identificador del macrociclo a procesar. Lista de valores.
        sbAnio: Identificador del a��o a procesar
     	sbMes: Identificador del mes a procesar
    	nuNumeroMeses de meses a buscar: Cantidad de meses hacia atr��s que el proceso buscar�� los cambios de ruta


        Valor de salida
        sbmensa  mensaje de error
        error

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/

   --Cursor que selecciona la informaci��n de las rutas
   -- se crea variable tipo record
	TYPE rcCurutaFact IS RECORD
    (
        anio                   perifact.pefaano%type,
        mes                    perifact.pefames%type,
        contrato               suscripc.susccodi%type,
        nombre                 varchar2(250),
        codigo_dir             ab_address.address_id%type,
        direccion              ab_address.address_parsed%type,
        localidad_id           ge_geogra_location.geograp_location_id%type,
        localidad              ge_geogra_location.description%type,
        categoria_cod          servsusc.sesucate%type,
        categoria              categori.catedesc%type,
        subcategoria_cod       servsusc.sesusuca%type,
        des_subcategoria       subcateg.sucadesc%type,
        ciclo                  perifact.pefacicl%type,
        nom_ciclo              varchar2(250),
        fec_regi_ruta          ed_document.docufere%type,
        periodo                perifact.pefacodi%type,
        localidad_padre        ge_geogra_location.geo_loca_father_id%type,
        Ruta                   varchar2(250),
        documento              ed_document.docucodi%type
     );

    TYPE tytbCureporte IS TABLE OF rcCurutaFact INDEX BY pls_integer;
    tbReporte tytbCureporte;


     cursor cuRUTAFACTURA(nuCiclo in number,
                        nuMesIni in number,
                        nuMesFin in number,
                        nuAno in number) is
		 SELECT /*+ index(se PK_SERVSUSC) index(ciclo PK_CICLO)*/
			   pe.pefaano anio,
			   pe.pefames mes,
			   fa.factsusc contrato,
			   ge.subscriber_name||' '||ge.subs_last_name nombre,
			   d.address_id codigo_dir,
			   d.address_parsed direccion,
			   i.geograp_location_id localidad_id,
			   i.description localidad,
			   se.sesucate categoria_cod,
			   catedesc categoria,
			   se.sesusuca subcategoria_cod,
			   sucadesc des_subcategoria,
			   pe.pefacicl ciclo,
			   cicldesc nom_ciclo,
			   docufere fec_regi_ruta,
			   pe.pefacodi periodo,
			   i.geo_loca_father_id localidad_padre,
			   SUBSTR(do.docudocu,instr(do.docudocu,'<RUTA>')+6,(instr(do.docudocu,'</RUTA>')-(instr(do.docudocu,'<RUTA>')+6))) Ruta,
			   do.docucodi documento
		 FROM open.factura fa,
			  open.perifact pe,
			  open.ed_document do,
			  open.ge_subscriber ge,
			  open.suscripc s,
			  open.ab_address d,
			  open.ge_geogra_location i,
			  open.pr_product pr,
			  open.servsusc se,
			  open.categori,
			  open.subcateg,
			  open.ciclo
		WHERE pe.pefacicl = nuCiclo
		  AND pe.pefaano  = nuAno
		  AND (pe.pefames >= nuMesIni and pe.pefames <= nuMesFin)
		  AND fa.factpefa = pe.pefacodi
		  AND do.docucodi = fa.factcodi
		  AND do.docupefa = fa.factpefa
		  AND do.docutido = fa.factcons
		  AND s.susccodi  = fa.factsusc
		  AND pr.subscription_id = fa.factsusc
		  AND se.sesunuse  = pr.product_id
		  AND ge.subscriber_id = s.suscclie
		  AND se.sesuserv = 7014
		  AND d.address_id = s.susciddi
		  AND i.geograp_location_id = d.geograp_location_id
		  AND catecodi = se.sesucate
		  AND sucacate = catecodi
		  AND sucacate = se.sesucate
		  AND sucacodi = se.sesusuca
		  AND ciclcodi = pe.pefacicl
		  ORDER BY pe.pefacicl, fa.factsusc, pe.pefames,docufere ASC;

     cursor cuLDC_HISTO_RUTAS_FACT(nuAnio in number,
                                   nuSusbcription_id in number,
                                   nuCiclo in number) is
       SELECT RUTA_ANT_ID,RUTA_NUEVA_ID,RUTA_ACTUAL_ID
         FROM open.LDC_HISTO_RUTAS_FACT
        WHERE ano = nuAnio
          AND SUBSCRIPTION_ID = nuSusbcription_id
          AND ciclo = nuCiclo
          AND rownum<=1
          ORDER BY ano,mes DESC;

     cursor cuRuta(nuRuta in number) is
       SELECT r.name
	     FROM open.or_route r
        WHERE route_id= nuRuta;


     cursor cuDepto(nugeo_loca_father_id in number) is
      SELECT DESCRIPTION
	    FROM open.ge_geogra_location
       WHERE geograp_location_id = nugeo_loca_father_id
         AND geog_loca_area_type = 2;

     cursor cuRutaActual(nufactura in number) is
      SELECT SUBSTR(docudocu,instr(docudocu,'<RUTA>')+6,(instr(docudocu,'</RUTA>')-(instr(docudocu,'<RUTA>')+6))) Ruta
        FROM open.ed_document
       WHERE docucodi = nuFactura;

     cursor cuCiclos(nuMacrociclo in number) is
     SELECT CIGCCICL
	   FROM open.LDC_CICLGRCI
      WHERE CIGCGRCI = nuMacrociclo;

    sbmensaje    varchar2(1000);
    sbNombRuta   varchar2(200);
    sbNombRuta2  varchar2(200);
    sbNombRuta3  varchar2(200);
    sbNombDepto  varchar2(200);
    sbRutaActual varchar2(100);
    nuRuta     number:=0;
    nuContrato number:=0;
    nuMesInicial number:=0;
BEGIN
    nuMesInicial:= nuMes - nuNumeroMeses;
    If nuMesInicial = 0 Then
       nuMesInicial:= nuMes;
    End If;
    FOR regCiclo in cuCiclos(nuMacrociclo) LOOP
	    --Abre el cursor con todas las facturas para un ciclo
        OPEN cuRUTAFACTURA(regCiclo.CIGCCICL,
                            nuMesInicial,
                            nuMes,
                            nuAnio);
        LOOP
		-- con el siguiente fetch se selecciona los primeros 1000 registros y no se cierra el cursor ya que debe continuar con los sigtes 1000
        FETCH cuRUTAFACTURA BULK COLLECT INTO tbreporte LIMIT 1000;

		--Cuando ya no hayan registros se sale de este fecth para continuar con los siguientes 1000
        EXIT WHEN tbreporte.COUNT = 0;

		    --Recorre los 1000 registros.
            FOR i IN 1 .. tbreporte.COUNT
             LOOP
                nuRuta := 0;
                OPEN cuDepto(to_number(tbreporte(i).localidad_padre));
                FETCH cuDepto into sbNombDepto;
                CLOSE cuDepto;
                SELECT nvl(max(factcodi),0) into nuContrato
				  FROM open.factura
                 WHERE factsusc = tbreporte(i).contrato;

                OPEN cuRutaActual(nuContrato);
                FETCH cuRutaActual into sbRutaActual;
                CLOSE cuRutaActual;

				--valida el ultimo registro de rutas por contrato y a��o y mes
                FOR regLDC_HISTO_RUTAS_FACT in cuLDC_HISTO_RUTAS_FACT(tbreporte(i).anio,
                                                                      tbreporte(i).contrato,
                                                                      tbreporte(i).ciclo)
                                                                      LOOP

                    IF to_number(regLDC_HISTO_RUTAS_FACT.RUTA_NUEVA_ID) = to_number(tbreporte(i).ruta) THEN
                        nuRuta := 1;
                    ELSE
                        nuRuta := regLDC_HISTO_RUTAS_FACT.RUTA_NUEVA_ID;
                    END IF;

                END LOOP cuLDC_HISTO_RUTAS_FACT;
                --Si no hay registros crea el primer registro historico para poder comparar el que sigue
                IF (nuRuta = 0 and tbreporte(i).ruta is not null) THEN

                    OPEN  cuRuta(to_number(tbreporte(i).ruta));
                    FETCH cuRuta into sbNombRuta;
                    CLOSE cuRuta;
                    OPEN  cuRuta(to_number(sbRutaActual));
                    FETCH cuRuta into sbNombRuta3;
                    CLOSE cuRuta;

                    INSERT INTO OPEN.LDC_HISTO_RUTAS_FACT
                            VALUES (tbreporte(i).anio,
                                    tbreporte(i).mes,
                                    tbreporte(i).contrato,
                                    tbreporte(i).nombre,
                                    tbreporte(i).codigo_dir,
                                    tbreporte(i).direccion,
                                    to_number(tbreporte(i).localidad_padre),
                                    sbNombDepto,
                                    tbreporte(i).localidad_id,
                                    tbreporte(i).localidad,
                                    tbreporte(i).categoria_cod,
                                    tbreporte(i).categoria,
                                    tbreporte(i).subcategoria_cod,
                                    tbreporte(i).des_subcategoria,
                                    null,--ruta anterior
                                    null,--nomb ruta anterior
                                    to_number(tbreporte(i).ruta), --ruta nueva
                                    sbNombRuta,
                                    sbRutaActual, --ruta actual
                                    sbNombRuta3, --nomb ruta actual
                                    tbreporte(i).periodo,
                                    tbreporte(i).ciclo,
                                    tbreporte(i).nom_ciclo);
                    COMMIT;
                ELSE
                    --Si el registro es diferente entonces crear un nuevo registro colocando en el campo ruta anterior el que ya existe.
                    IF (nuRuta <> 1 and tbreporte(i).ruta is not null) THEN

                        open cuRuta(to_number(tbreporte(i).ruta));
                        fetch cuRuta into sbNombRuta;
                        close cuRuta;
                        open cuRuta(nuRuta);
                        fetch cuRuta into sbNombRuta2;
                        close cuRuta;
                        open cuRuta(to_number(sbRutaActual));
                        fetch cuRuta into sbNombRuta3;
                        close cuRuta;
                        INSERT INTO OPEN.LDC_HISTO_RUTAS_FACT
                                VALUES (tbreporte(i).anio,
                                        tbreporte(i).mes,
                                        tbreporte(i).contrato,
                                        tbreporte(i).nombre,
                                        tbreporte(i).codigo_dir,
                                        tbreporte(i).direccion,
                                        to_number(tbreporte(i).localidad_padre),
                                        sbNombDepto,
                                        tbreporte(i).localidad_id,
                                        tbreporte(i).localidad,
                                        tbreporte(i).categoria_cod,
                                        tbreporte(i).categoria,
                                        tbreporte(i).subcategoria_cod,
                                        tbreporte(i).des_subcategoria,
                                        nuRuta,--ruta anterior
                                        sbNombRuta2,--nomb ruta anterior
                                        to_number(tbreporte(i).ruta), --ruta nueva
                                        sbNombRuta,--nomb ruta nueva
                                        sbRutaActual,--ruta actual
                                        sbNombRuta3, --nomb ruta actual
                                        tbreporte(i).periodo,
                                        tbreporte(i).ciclo,
                                        tbreporte(i).nom_ciclo);
                        COMMIT;
                    END IF;--If (nuRuta <> 1) Then
                END IF;--If (nuRuta = 0) Then
            END LOOP;--FOR i IN 1 .. tbreporte.COUNT
        END LOOP;
        CLOSE cuRUTAFACTURA;
    END LOOP;-- FOR regCiclo in cuCiclos(nuMacrociclo) LOOP
EXCEPTION
 WHEN OTHERS THEN
  ROLLBACK;
  sbmensa := 'Error en LDC_PRGENERATEDATA error code : '||TO_CHAR(SQLCODE)||' MENSAJE '||SQLERRM;
  error := -1;

END LDC_PRGENERATEDATA;

PROCEDURE PROCESS
IS

cnuNULL_ATTRIBUTE constant number := 2126;

sbANO ge_boInstanceControl.stysbValue;
sbMES ge_boInstanceControl.stysbValue;
sbEQUIPMENT_QUANTITY ge_boInstanceControl.stysbValue;
sbGRCICODI ge_boInstanceControl.stysbValue;


cursor cuPerifact(nuAnio in number,
                  nuMes in number) is
select count(1) from open.perifact
where PEFAANO = nuAnio
  and PEFAMES = nuMes;

nuExiste number:= 0;
nuExisteMes number:= 0;
nuMesAntes number:= 0;
nuAnio number:=0;
nuMes  number:=0;

BEGIN
    sbANO := ge_boInstanceControl.fsbGetFieldValue ('LDCI_PERIPROGINTE', 'ANO');
    sbMES := ge_boInstanceControl.fsbGetFieldValue ('LDCI_PERIPROGINTE', 'MES');
    sbEQUIPMENT_QUANTITY := ge_boInstanceControl.fsbGetFieldValue ('GE_SUBS_SALES_DATA', 'EQUIPMENT_QUANTITY');
    sbGRCICODI := ge_boInstanceControl.fsbGetFieldValue ('LDC_GRUPCICL', 'GRCICODI');
    nuAnio := to_number(sbANO);
    nuMes  := to_number(sbMES);
    open cuPerifact(nuAnio,nuMes);
    fetch cuPerifact into nuExiste;
    close cuPerifact;


    ------------------------------------------------
    -- Required Attributes
    ------------------------------------------------

    if (sbANO is null) then
        Errors.SetError (cnuNULL_ATTRIBUTE, 'A��o');
        raise ex.CONTROLLED_ERROR;
    end if;

    if (sbMES is null) then
        Errors.SetError (cnuNULL_ATTRIBUTE, 'Mes');
        raise ex.CONTROLLED_ERROR;
    end if;

    if (sbEQUIPMENT_QUANTITY is null) then
        Errors.SetError (cnuNULL_ATTRIBUTE, 'Cantidad de Meses hacia Atras');
        raise ex.CONTROLLED_ERROR;
    end if;

    if (sbGRCICODI is null) then
        Errors.SetError (cnuNULL_ATTRIBUTE, 'MacroCiclo');
        raise ex.CONTROLLED_ERROR;
    end if;

    If nuExiste = 0 Then
       Errors.SetError (-1843, ' y A��o invalido, no es un periodo de Facturaci��n');
       raise ex.CONTROLLED_ERROR;
    End If;
    nuMesAntes := to_number(sbMES) - to_number(sbEQUIPMENT_QUANTITY);
    open cuPerifact(nuAnio,nuMesAntes);
    fetch cuPerifact into nuExisteMes;
    close cuPerifact;
    If nuExisteMes = 0 Then
       Errors.SetError (to_number(900426), 'y no existe en el a��o del periodo Facturacion');
       raise ex.CONTROLLED_ERROR;
    End If;
    ------------------------------------------------
    -- User code
    ------------------------------------------------

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise;

    when OTHERS then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END;
END LDC_PKGRUTCONTCAM;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_PKGRUTCONTCAM
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PKGRUTCONTCAM', 'ADM_PERSON'); 
END;
/
