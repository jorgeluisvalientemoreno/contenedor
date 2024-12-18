REM Fuente="Propiedad Intelectual de Gases del Caribe"
REM Script		 :		tstringtable.sql
REM Autor 		 :		Diana Saltarín - GdC, Luis Javier López - Horbath, Lubin Pineda - MVM
REM Fecha 		 :		08-02-2023
REM Descripcion	 :		Se crea el tipo de dato tStringTable
REM Caso	     :		OSF-858
CREATE OR REPLACE TYPE personalizaciones.tStringTable
AS TABLE OF VARCHAR2(255)
/