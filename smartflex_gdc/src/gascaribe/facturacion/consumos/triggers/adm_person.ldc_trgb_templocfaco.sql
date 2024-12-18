create or replace trigger adm_person.LDC_TRGB_TEMPLOCFACO
before insert on ldc_templocfaco
for each row

  /*****************************************************************

    Propiedad intelectual de Gases del Caribe S.A.


    Unidad         : LDC_TRGB_TEMPLOCFACO

    Descripcion    : Cada vez que se haga insert a la tabla ldc_templocfaco
                     se valida: que la localida tenga configurada las variables fijas
                     de LDC_VARIFACOLO, si esto es asi permitira insert a la tabla LDC_TEMPLOCFACO
                     
    Autor          : Ronald Colpas Cantillo
    Fecha          : 04/01/2018

    Historia de Modificaciones

      Fecha             Autor             Modificacion
    =========         =========         ====================
    22-jun-2018       Roncol            Se modifica para que valide la si existe configuracion registrado
                                        para el periodo aÃ±o mes.
                                        Valida que haya fecha de periodo de consumo para la capital para aÃ±o y mes.
                                        Inicializa los campos que estan deshabilitados en el MD.
                                        Realiza calculo del valor promedio de la variable TEMPERATURA
    15-Ago-2023       jpinedc           OSF-1435: Se modifica el calculo
                                        de new.valor_prom
    17-Oct-2024       jpinedc           OSF-3383: Se migra a ADM_PERSON
  ******************************************************************/



declare

    nuExL     Number;
    dtFec     Date;

    CURSOR cuCM_VARS_AVG_MAX_DAYS 
    IS
    SELECT value 
    FROM ge_parameter 
    WHERE parameter_id = 'CM_VARS_AVG_MAX_DAYS';

    nuCM_VARS_AVG_MAX_DAYS NUMBER;

    cursor cuTemperatura( inuCapital NUMBER, inuCM_VARS_AVG_MAX_DAYS NUMBER )
    IS
    select v.vvfcvafc, SUM( v.vvfcvalo ) SumaValtemp, COUNT(1) CantidadValtemp
    from cm_vavafaco v
    where v.vvfcvafc = 'TEMPERATURA'
    and v.vvfcubge = inuCapital
    and v.vvfcfefv >= sysdate - inuCM_VARS_AVG_MAX_DAYS
    group by v.vvfcvafc;
    
    rcTemperatura cuTemperatura%ROWTYPE;
    
    PROCEDURE pCierraCursores
    IS
    BEGIN

        ut_trace.trace('Inicio LDC_TRGB_TEMPLOCFACO.pCierraCursores', 10);
        
        IF cuCM_VARS_AVG_MAX_DAYS%IsOpen THEN
            CLOSE cuCM_VARS_AVG_MAX_DAYS;
        END IF;

        IF cuTemperatura%IsOpen THEN
            CLOSE cuTemperatura;
        END IF;

        ut_trace.trace('Termina LDC_TRGB_TEMPLOCFACO.pCierraCursores', 10);
        
    END pCierraCursores;

begin

    ut_trace.trace('Inicio LDC_TRGB_TEMPLOCFACO', 10);
    
    pCierraCursores;

    --Validamos que no exista registro para la capital.    
    select count(*)
    into nuExL
    from ldc_templocfaco l
    where capital = :new.capital
    and temp_ano = :new.temp_ano
    and temp_mes = :new.temp_mes;

    if nuExL != 0 then
        pkg_error.setErrorMessage( isbMsgErrr =>
                        'Existe periodo: '|| :new.temp_ano||'-'||:new.temp_mes||
                        ', registrado para la localidad capital: '|| :new.capital || ' (ldc_templocfaco)');
    end if;
    
    --Validamos si la ciudad capital tenga localidades asociadas
    select count(*)
    into nuExL
    from ldc_capilocafaco c
    where c.capital = :new.capital;

    if nuExL = 0 then
        pkg_error.setErrorMessage( isbMsgErrr =>
                        'No se encontro localidades configuradas para la localidad capital: '|| :new.capital || ' (Ldc_capilocafaco)');

    end if;

    --Validad que hayan variables configuradas para la localidad
    select count(*)
    into nuExL
    from ldc_capilocafaco, Ldc_varifacolo
    where (capital = :new.capital or localidad = :new.capital)
    and ubicacion_localidad = localidad;

    if nuExL = 0 or nuExL is null then
        pkg_error.setErrorMessage( isbMsgErrr =>
                        'La localidad Capital: ' || :new.capital || ', no tiene ' ||
                        'configurada localidades con variables fijas (Ldc_varifacolo)');
    end if;

    --Valida que las variables fijas para la localidad esten configuradas con sus valores
    select count(*)
    into nuExL
    from ldc_capilocafaco, Ldc_varifacolo
    where (capital = :new.capital or localidad = :new.capital)
    and ubicacion_localidad = localidad
    and valor_variable is null
    and promedio_variable is null;
     
    if nuExL > 0 or nuExL is null then
        pkg_error.setErrorMessage( isbMsgErrr =>
                        'Las localidades asociadas a la ciudad capital: ' ||
                        :new.capital || ', no tienen ' ||
                        'configurados los valores de las variables fijas (Ldc_varifacolo)');
    end if;

    --Valida que el periodo de facturaciÃ³n exista 
    select count(*) into nuExL
    from perifact
    where pefaano = :new.temp_ano
    and pefames = :new.temp_mes;

    if nuExL = 0 then
        pkg_error.setErrorMessage( isbMsgErrr =>
                        'No se encontro periodo de facturaciÃ³n para el aÃ±o: '|| :new.temp_ano ||' y mes: ' || :new.temp_mes );
    end if;

    --Valida que haya fecha de periodo de consumo para la capital
    dtFec := ldc_funfechintemp(:new.capital, :new.temp_ano, :new.temp_mes);

    if dtFec is null then
        pkg_error.setErrorMessage( isbMsgErrr =>
                        'No se encontro fecha de vigencia inicial para la ciudad capital: ' || :new.capital );
    end if;

    --Inicialezamos los campos que estan deshabilitados antes de hacer el insert
    :new.fecha_ini := trunc(dtFec);
    :new.fecha_fin := to_date('31/12/4732', 'dd/mm/yyyy');
    :new.fecha_reg := trunc(sysdate);
    :new.estado_apro := 'P';
    :new.usuario := user;
    :new.terminal := userenv('TERMINAL');

    OPEN cuCM_VARS_AVG_MAX_DAYS;
    FETCH cuCM_VARS_AVG_MAX_DAYS INTO nuCM_VARS_AVG_MAX_DAYS;
    CLOSE cuCM_VARS_AVG_MAX_DAYS;
    
    ut_trace.trace('nuCM_VARS_AVG_MAX_DAYS|'||nuCM_VARS_AVG_MAX_DAYS, 10);
  
    IF nuCM_VARS_AVG_MAX_DAYS  = 0 THEN
        :new.valor_prom := :new.valor;
    ELSE
  
        --Calcular valor promedio de la temperatura
        open cuTemperatura( :new.capital, nuCM_VARS_AVG_MAX_DAYS );
        fetch cuTemperatura into rcTemperatura;
        close cuTemperatura;
        
        ut_trace.trace('rcTemperatura.SumaValtemp|'||rcTemperatura.SumaValtemp, 10);        

        ut_trace.trace('rcTemperatura.CantidadValtemp|'||rcTemperatura.CantidadValtemp, 10);        
        
        if rcTemperatura.vvfcvafc IS NULL then                        
            pkg_error.setErrorMessage( isbMsgErrr =>
                            'No se encontro valor de temperatura anterior, para la capital: ' || :new.capital );
        else        
            :new.valor_prom := (:new.valor + rcTemperatura.SumaValtemp) / ( 1 + rcTemperatura.CantidadValtemp );    
        end if;
        
    END IF;
  
    ut_trace.trace('Fin LDC_TRGB_TEMPLOCFACO', 10);
    
EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
        pCierraCursores;
        raise;
    WHEN OTHERS THEN
        pCierraCursores;
        raise;
end LDC_TRGB_TEMPLOCFACO;

/