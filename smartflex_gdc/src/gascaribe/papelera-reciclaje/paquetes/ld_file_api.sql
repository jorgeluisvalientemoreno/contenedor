CREATE OR REPLACE PACKAGE Ld_File_Api IS
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : Ld_File_Api
  Descripcion    : Paquete para la gestion de archivos
  Autor          : AAcuna
  Fecha          : 04/10/2012 SAO 147879

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============   ===================
  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  -- Declaracion de Tipos de datos publicos
 g_reply        t_string_table := t_string_table();
 g_debug        BOOLEAN := TRUE;
  -- Declaracion de variables publicas

  -----------------------
  -- Constants
  -----------------------
  -- Constante con el SAO de la ultima version aplicada
  csbVERSION CONSTANT VARCHAR2(10) := 'SAO147879';
  -----------------------
  --------------------------------------------------------------------
  -- Variables
  --------------------------------------------------------------------
  --------------------------------------------------------------------
  -- Cursores
  --------------------------------------------------------------------
  -----------------------------------
  -- Metodos publicos del package
  -----------------------------------
  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure      :  fsbVersion
  Descripcion    :  Obtiene la Version actual del Paquete

  Parametros     :  Descripcion
  Retorno        :
  csbVersion        Version del Paquete

  Autor          :  AAcuna SAO 147879
  Fecha          :  04/10/2012

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  *****************************************************************/

  FUNCTION fsbVersion return varchar2;
  sbconsultation varchar2(4000);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuCanRead
  Descripcion    : Leer un archivo
  Autor          : AAcu?a
  Fecha          : 04/10/2012


  Parametros         Descripcion
  ============  ===================
    isbPath:       Ruta de archivo

  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================

  ************************************************************/
   FUNCTION fnuCanRead(isbPath IN VARCHAR2) RETURN NUMBER;

   /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuCanWrite
  Descripcion    : Leer un archivo
  Autor          : AAcu?a
  Fecha          : 04/10/2012


  Parametros         Descripcion
  ============  ===================
    isbPath:       Ruta de archivo

  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================

  ************************************************************/

  FUNCTION fnuCanWrite(isbPath IN VARCHAR2) RETURN NUMBER;
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuCreateNewFile
  Descripcion    : Crea un nuevo archivo
  Autor          : AAcu?a
  Fecha          : 04/10/2012


  Parametros         Descripcion
  ============  ===================
    isbPath:       Ruta de archivo

  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================

  ************************************************************/

  FUNCTION fnuCreateNewFile(isbPath IN VARCHAR2) RETURN NUMBER;
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuDelete
  Descripcion    : Borrar un archivo
  Autor          : AAcu?a
  Fecha          : 04/10/2012


  Parametros         Descripcion
  ============  ===================
    isbPath:       Ruta de archivo

  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================

  ************************************************************/


  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuExists
  Descripcion    : Si existe la carpeta
  Autor          : AAcu?a
  Fecha          : 04/10/2012


  Parametros         Descripcion
  ============  ===================
    isbPath:       Ruta de archivo

  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================

  ************************************************************/

  FUNCTION fnuExists(p_path IN VARCHAR2) RETURN NUMBER;
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuDirectory
  Descripcion    : Arbol de directorio
  Autor          : AAcu?a
  Fecha          : 04/10/2012


  Parametros         Descripcion
  ============  ===================
    isbPath:       Ruta de archivo

  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================

  ************************************************************/

  FUNCTION fnuDirectory(isbPath IN VARCHAR2) RETURN NUMBER;
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuFile
  Descripcion    : Leer un archivo
  Autor          : AAcu?a
  Fecha          : 04/10/2012


  Parametros         Descripcion
  ============  ===================
    isbPath:       Ruta de archivo

  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================

  ************************************************************/

  FUNCTION fnuFile(isbPath IN VARCHAR2) RETURN NUMBER;
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuHidden
  Descripcion    : Archivos ocultos
  Autor          : AAcu?a
  Fecha          : 04/10/2012


  Parametros         Descripcion
  ============  ===================
    isbPath:       Ruta de archivo

  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================

  ************************************************************/

  FUNCTION fnuHidden(isbPath IN VARCHAR2) RETURN NUMBER;
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fdtLastModified
  Descripcion    : Fecha de modificacion
  Autor          : AAcu?a
  Fecha          : 04/10/2012


  Parametros         Descripcion
  ============  ===================
    isbPath:       Ruta de archivo

  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================

  ************************************************************/

  FUNCTION fdtLastModified(isbPath IN VARCHAR2) RETURN DATE;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuLength
  Descripcion    : Longitud de la carpeta
  Autor          : AAcu?a
  Fecha          : 04/10/2012


  Parametros         Descripcion
  ============  ===================
    isbPath:       Ruta de archivo

  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================

  ************************************************************/

  FUNCTION fnuLength(isbPath IN VARCHAR2) RETURN NUMBER;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fsbList
  Descripcion    : Retorna un string con los Archivos de la carpeta
  Autor          : AAcu?a
  Fecha          : 04/10/2012


  Parametros         Descripcion
  ============  ===================
    isbPath:       Ruta de archivo

  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================

  ************************************************************/

  FUNCTION fsbList(isbPath IN VARCHAR2) RETURN VARCHAR2;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuMkDirs
  Descripcion    : Crear una carpeta
  Autor          : AAcu?a
  Fecha          : 04/10/2012


  Parametros         Descripcion
  ============  ===================
    isbPath:       Ruta de archivo

  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================

  ************************************************************/

  FUNCTION fnuMkDirs(isbPath IN VARCHAR2) RETURN NUMBER;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuRenameTo
  Descripcion    : Renombrar un archivo
  Autor          : AAcu?a
  Fecha          : 04/10/2012


  Parametros         Descripcion
  ============  ===================
  isbP_from_path:  Carpeta origen
  isbP_to_path:    Carpeta destino

  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================

  ************************************************************/

  FUNCTION fnuRenameTo(isbP_From_Path IN VARCHAR2,
                       isbP_To_Path   IN VARCHAR2) RETURN NUMBER;

   /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuSetReadOnly
  Descripcion    :
  Autor          : AAcu?a
  Fecha          : 04/10/2012


  Parametros         Descripcion
  ============  ===================
    isbPath:       Ruta de archivo

  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================

  ************************************************************/

  FUNCTION fnuSetReadOnly(isbPath IN VARCHAR2) RETURN NUMBER;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuCopy
  Descripcion    : Copiar un archivo
  Autor          : AAcu?a
  Fecha          : 04/10/2012


  Parametros         Descripcion
  ============  ===================
  isbP_from_path:  Carpeta origen
  isbP_to_path:    Carpeta destino

  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================

  ************************************************************/

  FUNCTION fnuCopy(isbP_from_path IN VARCHAR2, isbP_to_path IN VARCHAR2)
    RETURN NUMBER;

   /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcGetDirList
  Descripcion    : Retorna un objeto de tipo t_string_table
  Autor          : AAcu?a
  Fecha          : 04/10/2012


  Parametros         Descripcion
  ============  ===================
    isbPath:       Ruta de archivo
    isbExt:        Extension

  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================

  ************************************************************/

  PROCEDURE ProcGetDirList(isbPath      IN VARCHAR2,isbExt      IN VARCHAR2,
                           osbP_dirList OUT t_string_table);


   PROCEDURE get_reply(p_conn IN OUT NOCOPY UTL_TCP.connection);

    PROCEDURE send_command(p_conn    IN OUT NOCOPY UTL_TCP.connection,
                         p_command IN VARCHAR2,
                         p_reply   IN BOOLEAN := TRUE);

                          PROCEDURE debug(p_text IN VARCHAR2) ;

                          FUNCTION login(p_host    IN VARCHAR2,
                 p_port    IN VARCHAR2,
                 p_user    IN VARCHAR2,
                 p_pass    IN VARCHAR2,
                 p_timeout IN NUMBER := NULL) RETURN UTL_TCP.connection;

END Ld_File_Api;
/
CREATE OR REPLACE PACKAGE BODY Ld_File_Api IS
  -- Declaracion de variables y tipos globales privados del paquete

  -- Definicion de metodos publicos y privados del paquete

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure      :  fsbVersion
  Descripcion    :  Obtiene la Version actual del Paquete

  Parametros     :  Descripcion
  Retorno        :
  csbVersion        Version del Paquete

  Autor          :  AAcu?a SAO 147879
  Fecha          :  20/09/2012

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  *****************************************************************/

  FUNCTION fsbVersion RETURN varchar2 IS
  BEGIN
    pkErrors.Push('Ld_BoSecureManagement.fsbVersion');
    pkErrors.Pop;
    -- Retorna el SAO con que se realizo la ultima entrega
    RETURN(csbVersion);
  END fsbVersion;
/*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuCanRead
  Descripcion    : Leer un archivo
  Autor          : AAcu?a
  Fecha          : 04/10/2012


  Parametros         Descripcion
  ============  ===================
    isbPath:       Ruta de archivo

  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================

  ************************************************************/
  FUNCTION fnuCanRead(isbPath IN VARCHAR2) RETURN NUMBER AS
    LANGUAGE JAVA NAME 'ManagementFile.canRead (java.lang.String) return java.lang.int';
/*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuCanWrite
  Descripcion    : Leer un archivo
  Autor          : AAcu?a
  Fecha          : 04/10/2012


  Parametros         Descripcion
  ============  ===================
    isbPath:       Ruta de archivo

  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================

  ************************************************************/
  FUNCTION fnuCanWrite(isbPath IN VARCHAR2) RETURN NUMBER AS
    LANGUAGE JAVA NAME 'ManagementFile.canWrite (java.lang.String) return java.lang.int';
 /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuCreateNewFile
  Descripcion    : Crea un nuevo archivo
  Autor          : AAcu?a
  Fecha          : 04/10/2012


  Parametros         Descripcion
  ============  ===================
    isbPath:       Ruta de archivo

  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================

  ************************************************************/

  FUNCTION fnuCreateNewFile(isbPath IN VARCHAR2) RETURN NUMBER AS
    LANGUAGE JAVA NAME 'ManagementFile.createNewFile (java.lang.String) return java.lang.int';
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuDelete
  Descripcion    : Borrar un archivo
  Autor          : AAcu?a
  Fecha          : 04/10/2012


  Parametros         Descripcion
  ============  ===================
    isbPath:       Ruta de archivo

  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================

  ************************************************************/

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuExists
  Descripcion    : Si existe la carpeta
  Autor          : AAcu?a
  Fecha          : 04/10/2012


  Parametros         Descripcion
  ============  ===================
    isbPath:       Ruta de archivo

  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================

  ************************************************************/
  FUNCTION fnuExists(p_path IN VARCHAR2) RETURN NUMBER AS
    LANGUAGE JAVA NAME 'ManagementFile.exists (java.lang.String) return java.lang.int';

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuDirectory
  Descripcion    : Arbol de directorio
  Autor          : AAcu?a
  Fecha          : 04/10/2012


  Parametros         Descripcion
  ============  ===================
    isbPath:       Ruta de archivo

  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================

  ************************************************************/
  FUNCTION fnuDirectory(isbPath IN VARCHAR2) RETURN NUMBER AS
    LANGUAGE JAVA NAME 'ManagementFile.isDirectory (java.lang.String) return java.lang.int';
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuFile
  Descripcion    : Leer un archivo
  Autor          : AAcu?a
  Fecha          : 04/10/2012


  Parametros         Descripcion
  ============  ===================
    isbPath:       Ruta de archivo

  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================

  ************************************************************/
  FUNCTION fnuFile(isbPath IN VARCHAR2) RETURN NUMBER AS
    LANGUAGE JAVA NAME 'ManagementFile.isFile (java.lang.String) return java.lang.int';

   /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuHidden
  Descripcion    : Archivos ocultos
  Autor          : AAcu?a
  Fecha          : 04/10/2012


  Parametros         Descripcion
  ============  ===================
    isbPath:       Ruta de archivo

  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================

  ************************************************************/

  FUNCTION fnuHidden(isbPath IN VARCHAR2) RETURN NUMBER AS
    LANGUAGE JAVA NAME 'ManagementFile.isHidden (java.lang.String) return java.lang.int';

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fdtLastModified
  Descripcion    : Fecha de modificacion
  Autor          : AAcu?a
  Fecha          : 04/10/2012


  Parametros         Descripcion
  ============  ===================
    isbPath:       Ruta de archivo

  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================

  ************************************************************/

  FUNCTION fdtLastModified(isbPath IN VARCHAR2) RETURN DATE AS
    LANGUAGE JAVA NAME 'ManagementFile.lastModified (java.lang.String) return java.sql.Timestamp';

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuLength
  Descripcion    : Longitud de la carpeta
  Autor          : AAcu?a
  Fecha          : 04/10/2012


  Parametros         Descripcion
  ============  ===================
    isbPath:       Ruta de archivo

  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================

  ************************************************************/

  FUNCTION fnuLength(isbPath IN VARCHAR2) RETURN NUMBER AS
    LANGUAGE JAVA NAME 'ManagementFile.length (java.lang.String) return java.lang.long';

   /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fsbList
  Descripcion    : Retorna un string con los Archivos de la carpeta
  Autor          : AAcu?a
  Fecha          : 04/10/2012


  Parametros         Descripcion
  ============  ===================
    isbPath:       Ruta de archivo

  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================

  ************************************************************/


  FUNCTION fsbList(isbPath IN VARCHAR2) RETURN VARCHAR2 AS
    LANGUAGE JAVA NAME 'ManagementFile.list (java.lang.String) return java.lang.String';

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuMkDirs
  Descripcion    : Crear una carpeta
  Autor          : AAcu?a
  Fecha          : 04/10/2012


  Parametros         Descripcion
  ============  ===================
    isbPath:       Ruta de archivo

  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================

  ************************************************************/

  FUNCTION fnuMkDirs(isbPath IN VARCHAR2) RETURN NUMBER AS
    LANGUAGE JAVA NAME 'ManagementFile.mkdirs (java.lang.String) return java.lang.int';

   /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuRenameTo
  Descripcion    : Renombrar un archivo
  Autor          : AAcu?a
  Fecha          : 04/10/2012


  Parametros         Descripcion
  ============  ===================
  isbP_from_path:  Carpeta origen
  isbP_to_path:    Carpeta destino

  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================

  ************************************************************/

  FUNCTION fnuRenameTo(isbP_From_Path IN VARCHAR2,
                       isbP_To_Path   IN VARCHAR2) RETURN NUMBER AS
    LANGUAGE JAVA NAME 'ManagementFile.renameTo (java.lang.String, java.lang.String) return java.lang.int';

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuSetReadOnly
  Descripcion    :
  Autor          : AAcu?a
  Fecha          : 04/10/2012


  Parametros         Descripcion
  ============  ===================
    isbPath:       Ruta de archivo

  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================

  ************************************************************/


  FUNCTION fnuSetReadOnly(isbPath IN VARCHAR2) RETURN NUMBER AS
    LANGUAGE JAVA NAME 'ManagementFile.setReadOnly (java.lang.String) return java.lang.int';

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuCopy
  Descripcion    : Copiar un archivo
  Autor          : AAcu?a
  Fecha          : 04/10/2012


  Parametros         Descripcion
  ============  ===================
  isbP_from_path:  Carpeta origen
  isbP_to_path:    Carpeta destino

  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================

  ************************************************************/

  FUNCTION fnuCopy(isbP_from_path IN VARCHAR2, isbP_to_path IN VARCHAR2)
    RETURN NUMBER AS
    LANGUAGE JAVA NAME 'ManagementFile.copy (java.lang.String, java.lang.String) return java.lang.int';

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcGetDirList
  Descripcion    : Retorna un objeto de tipo t_string_table
  Autor          : AAcu?a
  Fecha          : 04/10/2012


  Parametros         Descripcion
  ============  ===================
    isbPath:       Ruta de archivo
    isbExt:        Extension

  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================

  ************************************************************/

  PROCEDURE ProcGetDirList(isbPath      IN VARCHAR2,
                              isbExt    IN VARCHAR2,
                           osbP_dirList OUT t_string_table) AS
    LANGUAGE JAVA NAME 'ManagementFile.getList(java.lang.String,java.lang.String,oracle.sql.ARRAY[])';


 FUNCTION login(p_host    IN VARCHAR2,
                 p_port    IN VARCHAR2,
                 p_user    IN VARCHAR2,
                 p_pass    IN VARCHAR2,
                 p_timeout IN NUMBER := NULL) RETURN UTL_TCP.connection IS
    -- --------------------------------------------------------------------------
    l_conn UTL_TCP.connection;

  BEGIN
    g_reply.delete;

    l_conn := UTL_TCP.open_connection(p_host,
                                      p_port,
                                      tx_timeout => p_timeout);
    get_reply(l_conn);
    send_command(l_conn, 'USER ' || p_user);
    send_command(l_conn, 'PASS ' || p_pass);
    RETURN l_conn;
  END;

    -- --------------------------------------------------------------------------
  PROCEDURE get_reply(p_conn IN OUT NOCOPY UTL_TCP.connection) IS
    -- --------------------------------------------------------------------------
    l_reply_code VARCHAR2(3) := NULL;
  BEGIN
    LOOP
      g_reply.extend;
      g_reply(g_reply.last) := UTL_TCP.get_line(p_conn, TRUE);
      debug(g_reply(g_reply.last));
      IF l_reply_code IS NULL THEN
        l_reply_code := SUBSTR(g_reply(g_reply.last), 1, 3);
      END IF;
      IF SUBSTR(l_reply_code, 1, 1) = '5' THEN
        RAISE_APPLICATION_ERROR(-20000, g_reply(g_reply.last));
      ELSIF (SUBSTR(g_reply(g_reply.last), 1, 3) = l_reply_code AND
            SUBSTR(g_reply(g_reply.last), 4, 1) = ' ') THEN
        EXIT;
      END IF;
    END LOOP;
  EXCEPTION
    WHEN UTL_TCP.END_OF_INPUT THEN
      NULL;
  END;

  PROCEDURE send_command(p_conn    IN OUT NOCOPY UTL_TCP.connection,
                         p_command IN VARCHAR2,
                         p_reply   IN BOOLEAN := TRUE) IS
    -- --------------------------------------------------------------------------
    l_result PLS_INTEGER;
  BEGIN
    l_result := UTL_TCP.write_line(p_conn, p_command);
    -- If you get ORA-29260 after the PASV call, replace the above line with the following line.
    -- l_result := UTL_TCP.write_text(p_conn, p_command || utl_tcp.crlf, length(p_command || utl_tcp.crlf));

    IF p_reply THEN
      get_reply(p_conn);
    END IF;
  END;

  PROCEDURE debug(p_text IN VARCHAR2) IS
    -- --------------------------------------------------------------------------
  BEGIN
    IF g_debug THEN
      DBMS_OUTPUT.put_line(SUBSTR(p_text, 1, 255));
    END IF;
  END;

END Ld_File_Api;
/
