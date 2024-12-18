CREATE OR REPLACE PACKAGE ldc_pk_parametros_vistas AS
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : 
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    28/06/2024              PAcosta         OSF-2882: Se elimina la sentencia:
                                            "nootrespu   ldc_encuesta.orden_id%TYPE;" por borrado de la tabla LDC_ENCUESTA
                                            en el caso OSF-2882
    ****************************************************************/                                       


/**************************************************************************
    Autor       : John Jairo Jimenez Marimon
    Fecha       : 2014-10-30
    Descripcion : Paquete variables para vistas
***************************************************************************/
 nuvadepa    open.ge_geogra_location.geo_loca_father_id%TYPE;
 nuvaloca    open.ge_geogra_location.geograp_location_id%TYPE;
 nuvacate    open.categori.catecodi%TYPE;
 nuvasuca    open.subcateg.sucacodi%TYPE;
 nuvanuci    open.ciclo.ciclcodi%TYPE;
 nuvatipo    open.servsusc.sesuserv%TYPE;
 dtfein      DATE;
 dtfefi      DATE;
 sbform      ldc_osf_catecreg.cacrform%TYPE;
 sbprograma  ldc_osf_caussuco.programa%TYPE;
 sbconceptos VARCHAR2(1000);
 nupakano    NUMBER(4);
 nupakmes    NUMBER(2);
 nuclascont  concepto.concclco%TYPE;

 -- Retorna valor de la variable almacenada
 FUNCTION retorna_valor_campo(sdcampo VARCHAR2) RETURN NUMBER;
 FUNCTION retorna_valor_campo_fecha(sbcampo VARCHAR2) RETURN DATE;
 FUNCTION retorna_valor_campo_char(sbcampo VARCHAR2) RETURN VARCHAR2;
END;
/
CREATE OR REPLACE PACKAGE BODY ldc_pk_parametros_vistas AS

 FUNCTION retorna_valor_campo(sdcampo VARCHAR2) RETURN NUMBER IS
 /**************************************************************************
    Autor       : John Jairo Jimenez Marimon
    Fecha       : 2014-10-30
    Descripcion : Retorna valor de la vble de paquete

    Parametros Entrada
    Valor de salida

   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR   DESCRIPCION
***************************************************************************/
  BEGIN
   IF upper(sdcampo) = 'DEPA' THEN
    RETURN ldc_pk_parametros_vistas.nuvadepa;
   ELSIF upper(sdcampo) = 'LOCA' THEN
    RETURN ldc_pk_parametros_vistas.nuvaloca;
   ELSIF upper(sdcampo) = 'CATE' THEN
    RETURN ldc_pk_parametros_vistas.nuvacate;
   ELSIF upper(sdcampo) = 'SUCA' THEN
    RETURN ldc_pk_parametros_vistas.nuvasuca;
   ELSIF upper(sdcampo) = 'CICL' THEN
    RETURN ldc_pk_parametros_vistas.nuvanuci;
   ELSIF upper(sdcampo) = 'TIPR' THEN
    RETURN ldc_pk_parametros_vistas.nuvatipo;
   ELSIF upper(sdcampo) = 'NUPKANO' THEN
    RETURN ldc_pk_parametros_vistas.nupakano;
   ELSIF upper(sdcampo) = 'NUPKMES' THEN
    RETURN ldc_pk_parametros_vistas.nupakmes;
   ELSIF upper(sdcampo) = 'NUCLCO' THEN
    RETURN ldc_pk_parametros_vistas.nuclascont;
   END IF;

  END retorna_valor_campo;
  FUNCTION retorna_valor_campo_fecha(sbcampo VARCHAR2) RETURN DATE IS
    /**************************************************************************
    Autor       : John Jairo Jimenez Marimon
    Fecha       : 2014-10-30
    Descripcion : Retorna valor de la vble de paquete Fecha

    Parametros Entrada
    Valor de salida

   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR   DESCRIPCION
***************************************************************************/
  BEGIN
    IF upper(sbcampo) = 'FEIN' THEN
     RETURN ldc_pk_parametros_vistas.dtfein;
   ELSIF upper(sbcampo) = 'FEFI' THEN
    RETURN ldc_pk_parametros_vistas.dtfefi;
  END IF;
 END;
 FUNCTION retorna_valor_campo_char(sbcampo VARCHAR2) RETURN VARCHAR2 IS
    /**************************************************************************
    Autor       : John Jairo Jimenez Marimon
    Fecha       : 2014-10-30
    Descripcion : Retorna valor de la vble de paquete varchar

    Parametros Entrada
    Valor de salida

   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR   DESCRIPCION
********************************************************************************/
 BEGIN
  IF upper(sbcampo) = 'SBFORM' THEN
    RETURN ldc_pk_parametros_vistas.sbform;
  ELSIF upper(sbcampo) = 'PROG' THEN
    RETURN ldc_pk_parametros_vistas.sbprograma;
  ELSIF upper(sbcampo) = 'CONC' THEN
    RETURN ldc_pk_parametros_vistas.sbconceptos;
 END IF;
END;
END ldc_pk_parametros_vistas;
/
GRANT EXECUTE on LDC_PK_PARAMETROS_VISTAS to SYSTEM_OBJ_PRIVS_ROLE;
GRANT DEBUG on LDC_PK_PARAMETROS_VISTAS to SYSTEM_OBJ_PRIVS_ROLE;
GRANT EXECUTE on LDC_PK_PARAMETROS_VISTAS to REXEOPEN;
GRANT EXECUTE on LDC_PK_PARAMETROS_VISTAS to REPORTES;
GRANT DEBUG on LDC_PK_PARAMETROS_VISTAS to REPORTES;
/
