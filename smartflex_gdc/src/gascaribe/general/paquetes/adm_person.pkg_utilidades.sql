create or replace package adm_person.pkg_utilidades IS
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : PKG_UTILIDADES
    Descripcion     : Paquete para crear utilidades generales
    Autor           : Luis Javier Lopez Barrios 
    Fecha           : 27-06-2023

    Parametros de Entrada     
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    	Descripcion
    Adrianavg   30/04/2024  OSF-2645    Quitar permisos al usuario INNOVACION en prAplicarPermisos y prCrearSinonimos
    jpinedc     06/02/2025  OSF-3940    Se modifica prCrearSinonimos
  ***************************************************************************/

  PROCEDURE prCrearSinonimos( isbObjeto   IN  VARCHAR2,
                              isbEsquema  IN  VARCHAR2  );
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prCrearSinonimos
    Descripcion     : proceso para crear sinonimos
    Autor           : Luis Javier Lopez Barrios 
    Fecha           : 27-06-2023

    Parametros de Entrada     
      isbObjeto       nombre del objeto
      isbEsquema      esquema dueño del objeto
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    Descripcion
  ***************************************************************************/
  PROCEDURE prEliminarSinonimos( isbObjeto   IN  VARCHAR2,
                                isbEsquema  IN  VARCHAR2 );
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prEliminarSinonimos
    Descripcion     : proceso para eliminar sinonimos
    Autor           : Luis Javier Lopez Barrios 
    Fecha           : 27-06-2023

    Parametros de Entrada     
      isbObjeto       nombre del objeto
      isbEsquema      esquema dueño del objeto
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    Descripcion
  ***************************************************************************/
  PROCEDURE prAplicarPermisos( isbObjeto   IN  VARCHAR2,
                              isbEsquema  IN  VARCHAR2  );
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prAplicarPermisos
    Descripcion     : proceso para aplicar permisos
    Autor           : Luis Javier Lopez Barrios 
    Fecha           : 27-06-2023

    Parametros de Entrada     
      isbObjeto       nombre del objeto
      isbEsquema      esquema dueño del objeto
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    Descripcion
  ***************************************************************************/
  PROCEDURE prEliminarPermisos( isbObjeto   IN  VARCHAR2,
                              isbEsquema  IN  VARCHAR2  );
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prEliminarPermisos
    Descripcion     : proceso para eliminar permisos
    Autor           : Luis Javier Lopez Barrios 
    Fecha           : 27-06-2023

    Parametros de Entrada     
      isbObjeto       nombre del objeto
      isbEsquema      esquema dueño del objeto
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    Descripcion
  ***************************************************************************/
END pkg_utilidades;
/

create or replace package body     adm_person.pkg_utilidades IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : PKG_UTILIDADES
    Descripcion     : Paquete para crear utilidades generales
    Autor           : Luis Javier Lopez Barrios
    Fecha           : 27-06-2023

    Parametros de Entrada
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    Descripcion
  ***************************************************************************/
  PROCEDURE prCrearSinonimos( isbObjeto   IN  VARCHAR2,
                              isbEsquema  IN  VARCHAR2  ) IS
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prCrearSinonimos
    Descripcion     : proceso para crear sinonimos
    Autor           : Luis Javier Lopez Barrios
    Fecha           : 27-06-2023

    Parametros de Entrada
      isbObjeto       nombre del objeto
      isbEsquema      esquema dueño del objeto
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso      Descripcion
    Adrianavg   30/04/2024  OSF-2645  Retirar instrucción para crear sinónimos en el esquema innovación    
	jsoto		23/08/2024  OSF-3137  Se obtiene el tipo de objeto para condicionar a que si esquema es open
									  y el tipo de objeto es diferente de TABLA O VISTA no se cree el sinónimo
									  en personalizaciones.
    jpinedc     06/02/2025  OSF-3940  Se agrega la creación de sinónimos para objetos del esquema MULTIEMPRESA
									  
  ***************************************************************************/

    sbTipoObje      VARCHAR2(4000);
  
    CURSOR cuGetInfoObje IS
    SELECT object_type
    FROM dba_objects
    WHERE object_name = UPPER(isbObjeto)
       AND object_type IN ('TABLE', 'PROCEDURE', 'PACKAGE', 'FUNCTION', 'VIEW', 'SEQUENCE');  

  BEGIN

    IF cuGetInfoObje%ISOPEN THEN
       CLOSE cuGetInfoObje;
    END IF;

    OPEN cuGetInfoObje;
    FETCH cuGetInfoObje INTO sbTipoObje;
    CLOSE cuGetInfoObje;
	

    IF isbEsquema = 'OPEN'  THEN
        execute immediate 'CREATE OR REPLACE SYNONYM adm_person.'||isbObjeto||' FOR '||isbEsquema||'.'||isbObjeto;
      IF sbTipoObje IN ('TABLE','VIEW') THEN
        execute immediate 'CREATE OR REPLACE SYNONYM personalizaciones.'||isbObjeto||' FOR '||isbEsquema||'.'||isbObjeto;
      END IF;
    END IF;

    IF isbEsquema = 'PERSONALIZACIONES' THEN
        execute immediate 'CREATE OR REPLACE SYNONYM open.'||isbObjeto||' FOR '||isbEsquema||'.'||isbObjeto;
        execute immediate 'CREATE OR REPLACE SYNONYM adm_person.'||isbObjeto||' FOR '||isbEsquema||'.'||isbObjeto;
    END IF;

    IF isbEsquema = 'ADM_PERSON' THEN
        execute immediate 'CREATE OR REPLACE SYNONYM open.'||isbObjeto||' FOR '||isbEsquema||'.'||isbObjeto;
        execute immediate 'CREATE OR REPLACE SYNONYM personalizaciones.'||isbObjeto||' FOR '||isbEsquema||'.'||isbObjeto;
    END IF;

    IF isbEsquema = 'INNOVACION' THEN
        execute immediate 'CREATE OR REPLACE SYNONYM open.'||isbObjeto||' FOR '||isbEsquema||'.'||isbObjeto;
        execute immediate 'CREATE OR REPLACE SYNONYM personalizaciones.'||isbObjeto||' FOR '||isbEsquema||'.'||isbObjeto;
        execute immediate 'CREATE OR REPLACE SYNONYM adm_person.'||isbObjeto||' FOR '||isbEsquema||'.'||isbObjeto;
    END IF;
    
    IF isbEsquema = 'MULTIEMPRESA' THEN
        execute immediate 'CREATE OR REPLACE SYNONYM open.'||isbObjeto||' FOR '||isbEsquema||'.'||isbObjeto;
        execute immediate 'CREATE OR REPLACE SYNONYM personalizaciones.'||isbObjeto||' FOR '||isbEsquema||'.'||isbObjeto;
        execute immediate 'CREATE OR REPLACE SYNONYM adm_person.'||isbObjeto||' FOR '||isbEsquema||'.'||isbObjeto;
    END IF;

  END prCrearSinonimos;
  PROCEDURE prEliminarSinonimos( isbObjeto   IN  VARCHAR2,
                              isbEsquema  IN  VARCHAR2  ) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prEliminarSinonimos
    Descripcion     : proceso para eliminar sinonimos
    Autor           : Luis Javier Lopez Barrios
    Fecha           : 27-06-2023

    Parametros de Entrada
      isbObjeto       nombre del objeto
      isbEsquema      esquema dueño del objeto
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    Descripcion
	jsoto		23/08/2024  OSF-3137  Si el objeto es del esquema OPEN y el permiso es EXECUTE no 
                                      no se debe otorgar grant a PERSONALIZACIONES
  ***************************************************************************/
  BEGIN
    execute immediate 'DROP SYNONYM '||isbEsquema||'.'||isbObjeto;
  END prEliminarSinonimos;
  PROCEDURE prAplicarPermisos( isbObjeto   IN  VARCHAR2,
                              isbEsquema  IN  VARCHAR2  ) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prAplicarPermisos
    Descripcion     : proceso para aplicar permisos
    Autor           : Luis Javier Lopez Barrios
    Fecha           : 27-06-2023

    Parametros de Entrada
      isbObjeto       nombre del objeto
      isbEsquema      esquema dueño del objeto
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso      Descripcion
    Adrianavg   30/04/2024  OSF-2645  Retirar instrucción para dar permisos al rol REXEINNOVA    
  ***************************************************************************/

    sbTipoObje      VARCHAR2(4000);
    sbPermisos      VARCHAR2(4000);

    CURSOR cuGetInfoObje IS
    SELECT object_type
    FROM dba_objects
    WHERE object_name = UPPER(isbObjeto)
       AND object_type IN ('TABLE', 'PROCEDURE', 'PACKAGE', 'FUNCTION', 'VIEW', 'SEQUENCE');

  BEGIN

    IF cuGetInfoObje%ISOPEN THEN
       CLOSE cuGetInfoObje;
    END IF;

    OPEN cuGetInfoObje;
    FETCH cuGetInfoObje INTO sbTipoObje;
    CLOSE cuGetInfoObje;

    IF sbTipoObje IS NULL THEN
       dbms_output.put_line(' objeto '||isbObjeto||' no existe');
    ELSE
        IF sbTipoObje = 'TABLE' THEN
           sbPermisos := 'SELECT,INSERT,DELETE,UPDATE';
        ELSIF sbTipoObje IN ( 'VIEW', 'SEQUENCE') THEN
            sbPermisos := 'SELECT';
        ELSE
            sbPermisos := 'EXECUTE';
        END IF;

        execute immediate 'GRANT '||sbPermisos||' ON '||isbEsquema||'.'||isbObjeto||' TO SYSTEM_OBJ_PRIVS_ROLE';
		
       IF UPPER(isbEsquema) <> 'PERSONALIZACIONES' THEN
          IF (UPPER(isbEsquema) = 'OPEN' AND sbPermisos = 'EXECUTE') THEN
                    NULL;
                ELSE
                    execute immediate 'GRANT '||sbPermisos||' ON '||isbEsquema||'.'||isbObjeto||' TO PERSONALIZACIONES';
          END IF;
        END IF;
    
	END IF;
  END prAplicarPermisos;
  PROCEDURE prEliminarPermisos( isbObjeto   IN  VARCHAR2,
                                isbEsquema  IN  VARCHAR2  ) IS
 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prEliminarPermisos
    Descripcion     : proceso para eliminar permisos
    Autor           : Luis Javier Lopez Barrios
    Fecha           : 27-06-2023

    Parametros de Entrada
      isbObjeto       nombre del objeto
      isbEsquema      esquema dueño del objeto
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    Descripcion
  ***************************************************************************/
    CURSOR cuGetPermisos IS
    SELECT 'REVOKE  '||PRIVILEGE||' ON '||TABLE_NAME||' FROM '||GRANTEE cadena_sql
    FROM dba_tab_privs
    WHERE TABLE_NAME = UPPER(isbObjeto)
     AND GRANTEE =UPPER(isbEsquema);

  BEGIN
    FOR reg IN cuGetPermisos LOOP
       execute immediate reg.cadena_sql;
    END LOOP;
  END prEliminarPermisos;

END pkg_utilidades;
/

GRANT EXECUTE ON adm_person.pkg_utilidades TO SYSTEM_OBJ_PRIVS_ROLE;
GRANT EXECUTE ON adm_person.pkg_utilidades TO PERSONALIZACIONES;
/

