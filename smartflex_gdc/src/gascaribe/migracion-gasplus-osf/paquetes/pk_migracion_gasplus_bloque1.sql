CREATE OR REPLACE PACKAGE      "PK_MIGRACION_GASPLUS_BLOQUE1" as

  FUNCTION fsbVersion return varchar2;

  procedure AB_SYNONYM_C ( nuDataBase number, nuHilo number);

  procedure AB_SYNONYM_V ( nuDataBase number , nuHilo number);

  procedure AB_AWAY_BY_LOCATION_C ( nuDataBase number, nuHilo number);

  procedure AB_AWAY_BY_LOCATION_V ( nuDataBase number, nuHilo number);

  procedure AB_BLOCK_ ( nuDataBase number, nuHilo number);

  procedure or_route_( nuDataBase number, nuHilo number) ;

  procedure AB_SEGMENTS_C ( nuDataBase number, nuHilo number);

  procedure AB_SEGMENTS_V  ( nuDataBase number, nuHilo number);

  procedure LDC_MIG_DIRECCION_C ( nuDataBase number, nuHilo number);

  procedure LDC_MIG_DIRECCION_V ( nuDataBase number, nuHilo number);

  procedure LDC_MIG_PERIFACT ( nuDataBase number , nuHilo number );

  procedure PERIFACT_ ( nuDataBase number, nuHilo number);

  procedure PERICOSE_ ( nuDataBase number, nuHilo number);

  procedure AB_ADDRESS_ (nuDataBase number, nuHilo number )  ;

  procedure AB_ADDRESS_N (nuDataBase number, nuHilo number )  ;

  PROCEDURE prAlterTableDISABLE;
  PROCEDURE prDropTable;
  PROCEDURE prAlterTableENABLE;

  PROCEDURE tester (sbParametro1 varchar2, sbParametro2 varchar2);

END PK_MIGRACION_GASPLUS_bloque1;
/
