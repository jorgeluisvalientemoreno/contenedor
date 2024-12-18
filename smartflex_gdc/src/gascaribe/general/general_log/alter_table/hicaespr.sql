/*****************************************************************
Propiedad intelectual de GDCA


Nombre: Alter_HICAESPR
Descripción: Alter a la Tabla HICAESPR.

Autor : Edmundo Lara
Fecha : 30.09.2022 (Fecha Creación)  N° Tiquete (OSF-556)

Historia de Modificaciones

Fecha            Autor.                  Modificación
-----------    ----------  -------------------------------------
30-09-2022      EDMLAR     Se adiciona el campo Secuencia, con el fin de conocer el orden dentro en un proceso.

******************************************************************/

DECLARE
    /*Constante con el nombre de la Tabla y campo*/
    csbNameEntity VARCHAR2(30) := 'HICAESPR';
    csbNameColumn VARCHAR2(30) := 'HCETCONS';

    /* Consulta si existe la tabla y el campo */
    CURSOR cuExistsTable
    IS
        SELECT  count(*) 
          FROM  all_tab_columns 
         WHERE  table_name = UPPER(csbNameEntity)
           and  column_name = UPPER(csbNameColumn);


    /*Variable para almacenar sentencia SQL*/
    sbSql VARCHAR2(2000);

    /* Indica si existe la columna */
    nuExistsTable NUMBER;

    /* Indica si existe el usuario reportes */
    nuExistsReportes NUMBER;

BEGIN

    /*Si el CURSOR se encuentra abierto se procede con su cierre*/
    IF (cuExistsTable%ISOPEN) THEN
        CLOSE cuExistsTable;
    END IF;

    /* Valida si la tabla existe */
    OPEN cuExistsTable;
    FETCH cuExistsTable INTO nuExistsTable;
    CLOSE cuExistsTable;

    IF (nuExistsTable <> 0) THEN

        /*Si la tabla ya existe, se informa en consola acerca de su existencia*/
        dbms_output.put_Line('El campo en la Tabla HICAESPR ya existe');

    ELSE

        /* Instrucción para la creación de la tabla */
        
        sbSql := 'Alter Table HICAESPR ADD hcetcons NUMBER(15)';

        /* Ejecuta la instrucción */
        EXECUTE IMMEDIATE sbSql;

        /* Crea los comentarios de los campos  */
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN HICAESPR.HCETCONS IS ''Consecutivo del registro''';

        /*Se informa por consola la existencia de la tabla*/
        dbms_output.put_Line('Campo en la tabla HICAESPR Adicionado');

    END IF;
END;
/