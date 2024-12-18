CREATE OR REPLACE PACKAGE      pkg_constantes as

  /*******************************************************************************
   Package: pkg_constantes
  
   Descripción:   Constantes solapamiento
   Autor:         Pablo De La Peña
   Fecha:         25/06/2014
  
  *******************************************************************************/

  ----------------------------------------------------------------------------
  -- Constantes
  ----------------------------------------------------------------------------

  ----------------------------------------------------------------------------
  -- Cursores
  ----------------------------------------------------------------------------

  ----------------------------------------------------------------------------
  -- Tipos y Subtipos
  ----------------------------------------------------------------------------

  ----------------------------------------------------------------------------
  -- Variables
  ----------------------------------------------------------------------------
  FUNCTION fsbVersion return varchar2;

  procedure Complemento(inubasedato      in number,
                        onuComplementoPR out number,
                        onuComplementoSU out number,
                        onuComplementoFA out number,
                        onuComplementoCU out number,
                        onuComplementoDI out number);

  PROCEDURE PRGeneEsTAiN(TABLE_NAME IN VARCHAR2);

END PKG_CONSTANTES; 
/
CREATE OR REPLACE PACKAGE BODY      PKG_CONSTANTES as

  --------------------------------------------
  -- Constantes
  --------------------------------------------
  -- Esta constante se debe modificar cada vez que se entregue el paquete con un SAO
  csbVersion CONSTANT VARCHAR2(250) := 'SAOXXX7';
  --------------------------------------------
  -- Funciones y Procedimientos
  --------------------------------------------

  FUNCTION fsbVersion return varchar2 IS
  BEGIN
    Return csbVersion;
  END;

  procedure Complemento(inubasedato      in number,
                        onuComplementoPR out number,
                        onuComplementoSU out number,
                        onuComplementoFA out number,
                        onuComplementoCU out number,
                        onuComplementoDI out number) IS
  BEGIN
  
    if inubasedato = 1 then
      onuComplementoPR := 0;
      onuComplementoSU := 0;
      onuComplementoFA := 0;
      onuComplementoCU := 0;
      onuComplementoDI := 0;
    END IF;
  
    If inubasedato = 2 then
      onuComplementoPR := 0;
      onuComplementoSU := 100000;
      onuComplementoFA := 200000000;
      onuComplementoCU := 1000000000;
      onuComplementoDI := 10000000;
    eND IF;
  
    If inubasedato = 3 then
      onuComplementoPR := 500000;
      onuComplementoSU := 200000;
      onuComplementoFA := 300000000;
      onuComplementoCU := 2000000000;
      onuComplementoDI := 20000000;
    eND IF;
  
    If inubasedato = 4 then
      onuComplementoPR := 0;
      onuComplementoSU := 0;
      onuComplementoFA := 0;
      onuComplementoCU := 0;
      onuComplementoDI := 0;
    eND IF;
  
    If inubasedato = 5 then
      onuComplementoPR := 0;
      onuComplementoSU := 0;
      onuComplementoFA := 0;
      onuComplementoCU := 0;
      onuComplementoDI := 0;
    eND IF;
  
  END;
  PROCEDURE PRGeneEsTAiN(TABLE_NAME IN VARCHAR2)
  /************************************************************************
      Copyright (c) 2014 GASES DEL CARIBE E.S.P.
    
      NOMBRE       : PRGeneEstadistica
      AUTOR        : SINCECOMP - SAMUEL PACHECO
      FECHA        : 26-11-2014
      DESCRIPCION  : Procedimiento mediante el cual se genera estadistica
    
      Parametros de Entrada
    
      Parametros de Salida
    
      Historia de Modificaciones
      Autor       Fecha        Descripcion
    ************************************************************************/
   AS
  
  BEGIN
  
    --<<
    -- genera estadistica
    -->>
    EXECUTE IMMEDIATE ('BEGIN DBMS_STATS.GATHER_TABLE_STATS(' || CHR(39) ||
                      'OPEN' || CHR(39) || ',' || CHR(39) || table_name ||
                      CHR(39) ||
                      ', ESTIMATE_PERCENT => 100, CASCADE => TRUE); END;');
  
  END PRGeneEsTAiN;
END PKG_CONSTANTES; 
/
GRANT EXECUTE on PKG_CONSTANTES to SYSTEM_OBJ_PRIVS_ROLE;
GRANT EXECUTE on PKG_CONSTANTES to REXEOPEN;
/
