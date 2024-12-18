CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_RETORNACOMENTOTLEGA" (nuorden NUMBER) RETURN VARCHAR2 IS
/**************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2014-02-07
  Descripcion : Obtenemos los comentarios de una Orden

  Parametros Entrada
    nro Ot

  Valor de salida
    sbmen  mensaje
    error  codigo del error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION
   27/11/2019	DSALTARIN	236: SE MODIFICA APRA QUE NO ARROJE ERROR CUANDO LOS COMENTARIOS DE LA ORDEN SUPERAN LOS 4000 CARACTERES
***************************************************************************/
 CURSOR cuobservot(nuot NUMBER) IS
  SELECT o.order_comment observacion,  o.legalize_comment, length(trim(o.order_comment)) tama
    FROM or_order_comment o
   WHERE o.order_id = nuot
   --  AND o.legalize_comment = 'Y'
   ORDER BY o.register_date;
sbobserv VARCHAR2(5000);
nuValor number;
BEGIN
 sbobserv := NULL;
 FOR i IN cuobservot(nuorden) LOOP
	 if length(nvl(sbobserv,0)) + i.tama < 4000 then
		  sbobserv := sbobserv||TRIM(i.observacion);
	   else
		  if i.legalize_comment ='Y' then
			 nuValor :=length(nvl(sbobserv,0)) + i.tama;
			 if nuValor < 4000 then
				sbobserv := sbobserv||TRIM(i.observacion);
			 else
			   null;
			 end if;
			 sbobserv:=replace(sbobserv, substr(nvl(sbobserv,''), length(nvl(sbobserv,0))-i.tama),TRIM(i.observacion));
		  end if;
	end if;
 END LOOP;
 RETURN sbobserv;
EXCEPTION
 WHEN OTHERS THEN
  sbobserv := sbobserv||SQLERRM;
  RETURN sbobserv;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_RETORNACOMENTOTLEGA', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDC_RETORNACOMENTOTLEGA TO REXEREPORTES;
/
