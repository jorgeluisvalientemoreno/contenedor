create or replace procedure RevReconProduct
(
 inuproduct  in number
)

/**************************************************************************
  Autor       : Alejandro Cárdenas
  Fecha       : 2014-09-03
  Descripcion : Reversa el estado de corte de un producto de 6 a 1 y atiende el
                el registro en SUSPCONE.

 HISTORIA DE MODIFICACIONES
 FECHA        AUTOR    		DESCRIPCION
 12/09/2022	  cgonzalez 	Se ajusta para volver al ultimo estado de corte del producto
***************************************************************************/

IS
	CURSOR cuObtUltEstacort(inuProducto IN NUMBER) IS
		SELECT 	*
		FROM 	(SELECT	hcececan
				FROM 	hicaesco
				WHERE 	hcecnuse = inuProducto
				ORDER BY hcecfech DESC)
		WHERE ROWNUM = 1;
	
	nuUltEstacort	NUMBER;
BEGIN

    ut_trace.trace('Inicio Procedimiento RevReconProduct', 5);

    -- Establece Aplicación
    pkerrors.setapplication('WithDraw');

	OPEN cuObtUltEstacort(inuproduct);
	FETCH cuObtUltEstacort INTO nuUltEstacort;
	CLOSE cuObtUltEstacort;

    DBMS_LOCK.SLEEP(5);

    pktblservsusc.updsesuesco(inuproduct, nvl(nuUltEstacort, 1));

    UPDATE  suspcone
    SET     sucofeat = sysdate,
            sucoobse = 'ATENDIDA - El producto no está suspendido por Falta de Pago',
            sucotipo = 'A'
    WHERE   sucotipo = 'C'
            AND suconuse = inuproduct
            AND sucofeat IS null
            AND suconuor < 0;

    ut_trace.trace('Producto : '||inuproduct, 6);

    ut_trace.trace('Fin Procedimiento RevReconProduct', 5);

EXCEPTION

    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;

    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;

END RevReconProduct;
/