CREATE OR REPLACE PACKAGE        "PK_MIGRACION_GASPLUS_BLOQUE4" as

    FUNCTION fsbVersion return varchar2;

    procedure CUENCOBR_ (nuDataBase number, nuAno number, nuHilo number);
    procedure DIFERIDO_ (nuDataBase number, nuHilo number);
    procedure MOVIDIFE_ (nuDataBase number, nuHilo number );
    procedure CARGOS_ ( nuDataBase number, nuAno number, nuHilo number);
    procedure CUPON_ (numInicio NUMBER,numFinal NUMBER,nuDataBase number,nuHilo number);


    PROCEDURE tester (sbParametro1 varchar2, sbParametro2 varchar2);

END PK_MIGRACION_GASPLUS_bloque4;
/
