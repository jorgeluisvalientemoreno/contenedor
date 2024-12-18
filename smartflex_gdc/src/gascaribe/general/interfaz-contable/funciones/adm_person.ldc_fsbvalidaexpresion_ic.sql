CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FSBVALIDAEXPRESION_IC" (sbExpres1     in varchar2,
                                                     sbMOVICACA    in ic_movimien.movicaca%type,
                                                     sbMOVISERV    in ic_movimien.moviserv%type,
                                                     sbMOVITIHE    in ic_movimien.movitihe%type,
                                                     sbMOVICATE    in ic_movimien.movicate%type,
                                                     sbMOVISUCA    in ic_movimien.movisuca%type,
                                                     sbMOVISUBA    in ic_movimien.movisuba%type) return varchar2 is

  /*****************************************************************************
  Propiedad intelectual Gases del Caribe.
  Function:     Ldc_fsbValidaExpresion_IC
  Descripcion:  Funcion para validar la expresion de configuracion que se realiza en los registros de la
                interfaz contable de ingresos.
  Autor:        Diana Saltarin
  Fecha:        18-10-2022

  Parametros de Entrada:
                sbExpres1       :Expresion a validar de la configuracion contable
                sbMOVICACA      :Causal de la tabla         IC_MOVIMIEN
                sbMOVISERV      :Servicio de la tabla       IC_MOVIMIEN
                sbMOVITIHE      :Tipo de Hecho de la tabla  IC_MOVIMIEN
                sbMOVICATE      :Categoria de la tabla      IC_MOVIMIEN
                sbMOVISUCA      :Sub-categoria de la tabla  IC_MOVIMIEN
                sbMOVISUBA      :Sucursal Banco de la tabla IC_MOVIMIEN

  Parametros de Salida:
                Ninguno
  Retornos:
                S  Valida la expresion y es valida.
                N  Valida la expresion y No es valida
                X  Hubo error al ejecutar al funcion.


  Historia de modificaciones
  Fecha       Autor       Modificacion


  ******************************************************************************/

  sbValido        varchar2(1):='S';
  sbValido1       varchar2(1):='S';
  sbExpression    varchar(4000);



  function sbEvaluaExpression(sbExpress varchar2) return varchar2  is
    sbValor varchar2(1);
  begin
    begin
         execute immediate 'select ''S'' from dual where '||sbExpress INTO  sbValor ;
      exception
        when no_data_found then
             sbValor :='N';
      end;
    return sbValor;
  end;

begin
  sbExpression:=sbExpres1;
  if sbExpression is null or sbExpression = '' then
    sbValido :='S';
  else
    if sbExpression is not null then
      sbExpression := replace(sbExpression,'MOVICACA',sbMOVICACA);
      sbExpression := replace(sbExpression,'MOVISERV',sbMoviserv);
      sbExpression := replace(sbExpression,'MOVITIHE',''''||sbMOVITIHE||'''');
      sbExpression := replace(sbExpression,'MOVICATE',sbMOVICATE);
      sbExpression := replace(sbExpression,'MOVISUCA',sbMOVISUCA);
      sbExpression := replace(sbExpression,'MOVISUBA',sbMOVISUBA);
      sbValido1 := sbEvaluaExpression(sbExpression);

    else
      sbValido1 :='S';
    end if;
    if sbValido1 ='N' then
      sbValido :='N';
    end if;

  end if;
  return sbValido;
 Exception
   when others then
     dbms_output.put_line(sqlerrm);
       return 'X';
end;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FSBVALIDAEXPRESION_IC', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON LDC_FSBVALIDAEXPRESION_IC TO REPORTES;
/
