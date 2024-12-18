CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_PRGETINFOSUBSIDIO
      (
          INUPACKAGE_ID      IN   MO_PACKAGES.PACKAGE_ID%TYPE,
          ORFCURSORDATA      OUT  CONSTANTS.TYREFCURSOR
      )
      IS
/**************************************************************************
    Autor       : Miguel Angel Ballesteros Gomez / OlSOFTWARE
    Fecha       : 23/01/2020
    Ticket      : 198
    DempripciÃ³n: proceso usado como servicio que devuelve un cursor obteniendo
                 los datos de la informaciÃ³n del subsidio de acuerdo a la solicitud
				 creada en los tramites (Venta de gas cotizada y venta de gas por formulario)
    ParÃ¡metros Entrada
    INUPACKAGE_ID   Identificacion de la solicitud

    Valor de salida
    ORFCURSORDATA        Cursor que tiene el resutado de la consulta a nivel
                         de solicitud


    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DEmpRIPCION
***************************************************************************/

    SBSQL     VARCHAR2(32767);

BEGIN

      UT_TRACE.TRACE('Inicio de LDC_PRGETINFOSUBSIDIO PACKAGE_ID ['||INUPACKAGE_ID||']', 1);

     SBSQL :=   'Select t.PACKAGE_ID Solicitud, '                    ||CHR(10)||
                        ' t.APLICASUBSIDIO Aplica_Subsidio,'       	 ||CHR(10)||
                        ' t.TOTALSUBSIDIO Total_subsidio,'       	 ||CHR(10)||
                        ' t.VALBRUTOVENTA  Valor_Bruto_Venta,'       ||CHR(10)||
                        ' t.VALFINALVENTA Valor_Final_Venta,'        ||CHR(10)||
                        ' nvl(mp.package_id,0)  parent_id,'          ||CHR(10)||
						' ROWNUM ROWNUMTABLE'                        ||CHR(10)||
                    'from OPEN.LDC_SUBSIDIOS t,'             		 ||CHR(10)||
                         'open.mo_packages mp'                       ||CHR(10)||
                    'where t.PACKAGE_ID = mp.PACKAGE_ID'             ||CHR(10)||
                    'AND   mp.PACKAGE_ID = DECODE(:INUPACKAGE_ID,-1,T.PACKAGE_ID,:INUPACKAGE_ID)'          ||CHR(10)||
                     'order by T.PACKAGE_ID';

        UT_TRACE.TRACE('Sentencia: '||CHR(10)||SBSQL, 2);
        OPEN ORFCURSORDATA FOR SBSQL USING INUPACKAGE_ID, INUPACKAGE_ID;


      UT_TRACE.TRACE('Fin de LDC_PRGETINFOSUBSIDIO', 1);

EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
      RAISE EX.CONTROLLED_ERROR;
  WHEN OTHERS THEN
     ERRORS.SETERROR;
      RAISE EX.CONTROLLED_ERROR;

END LDC_PRGETINFOSUBSIDIO;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PRGETINFOSUBSIDIO', 'ADM_PERSON');
END;
/
