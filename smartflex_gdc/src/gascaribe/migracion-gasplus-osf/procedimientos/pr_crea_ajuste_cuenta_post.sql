CREATE OR REPLACE PROCEDURE PR_CREA_AJUSTE_CUENTA_post(ini number, fin number) IS
vj number;
cursor f is
Select Cargcuco,CUCONUSE, Cucovato,
       NVL(CUCOSACU,0) CUCOSACU,
       sum(Decode(Cargsign, 'DB', Cargvalo, 'CR', -Cargvalo, 'AS', -CARGVALO, 'PA',-CARGVALO)) SACU_CALCULADO,
       Sum(Decode(Cargsign, 'DB', Cargvalo, 'CR', -Cargvalo)) VATO_CALCULADO
       From Cargos, Cuencobr , factura
       Where Cargcuco = Cucocodi AND CUCONUSE>=ini and cuconuse<fin AND Cucocodi<>-1 and
             cucofact=factcodi AND trunc(factfege) <= to_date('31-01-2014','dd/mm/yyyy') AND
             NOT EXISTS (SELECT 'X' FROM CARGOS WHERE CARGCUCO=CUCOCODI AND TRUNC(CARGFECR)>to_date('02-02-2014','dd/mm/yyyy'))
       Group By Cargcuco, CUCONUSE, Cucovato,NVL(CUCOSACU,0),CUCOVAAB
       Having sum(Decode(Cargsign, 'DB', Cargvalo, 'CR', -Cargvalo,'AS',-CARGVALO,'PA',-CARGVALO)) <> NVL(CucoSACU,0);
NUCUENTA number;
NUPAGO             number(20) := 0;
nutotal number;
nuabono number;
nuvafa number;
gsig 	cargos.cargsign%type;
vlor    number;
nuLogError NUMBER;
CURSOR CARGOS_S (CU NUMBER) IS SELECT * FROM CARGOS WHERE CARGCUCO=CU AND ROWNUM=1;
CS CARGOS_S%ROWTYPE;
begin
     for c in f loop
         BEGIN
              NUCUENTA   := c.cargcuco;
              if c.sacu_calculado-c.cucosacu<>0 then
                 if c.sacu_calculado-c.cucosacu<0 then
                    gsig:='DB';
                 ELSE
                    GSIG:='CR';
                 END IF;
                 vlor:=abs(c.sacu_calculado-c.cucosacu);
                 OPEN CARGOS_S(NUCUENTA);
                 FETCH CARGOS_S INTO CS;
                 CLOSE CARGOS_S;
                 /* INSERTO CARGO EN CUENTA */
                 insert into CARGOS (CARGCUCO, CARGNUSE, CARGCONC, CARGCACA, CARGSIGN, CARGPEFA, CARGVALO,
	                          CARGDOSO, CARGCODO, CARGUSUA, CARGTIPR, CARGUNID, CARGFECR, CARGPROG, CARGCOLL,
				  CARGPECO, CARGTICO, CARGVABL, CARGTACO)
                          values (NUCUENTA, c.cuconuse, 475, 15, GSIG, CS.CARGPEFA, vlor,'AJUSTE POSMIGRACION', 0, 1, 'A', 0,
							  CS.CARGFECR, 161, NULL, CS.CARGPECO, NULL, NULL, NULL);
                 if c.cucovato=c.vato_calculado then
                    if gsig='DB' THEN
                       update cuencobr set cucovato=cucovato+abs(c.sacu_calculado-c.cucosacu) WHERE CUCOCODI=NUCUENTA;
                    ELSE
                       update cuencobr set cucovato=cucovato-abs(c.sacu_calculado-c.cucosacu) WHERE CUCOCODI=NUCUENTA;
                    END IF;
                 end if;
	         commit;
             end if;
	EXCEPTION
		WHEN OTHERS THEN
			null;
		end;
   end loop;
EXCEPTION
WHEN OTHERS THEN
     null;
end;
/
