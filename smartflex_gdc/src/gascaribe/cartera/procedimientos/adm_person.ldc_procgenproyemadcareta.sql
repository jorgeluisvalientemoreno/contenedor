CREATE OR REPLACE PROCEDURE adm_person.ldc_procgenproyemadcareta (
    inano        IN     NUMBER,
    inmes        IN     NUMBER,
    inservicio   IN     NUMBER,
    merro           OUT VARCHAR2)
IS
    /**************************************************************************
      Autor       : HORBATH
      Fecha       : 2019-11-12
      Descripcion : Generamos informacion para reportes de Maduracion de Cartera por etapas
                    GLPI 192
      Parametros Entrada
        inuano Ano
        inumes Mes
        inuserv  Tipo Producto

      Valor de salida
        merror  codigo del error

     HISTORIA DE MODIFICACIONES
       FECHA              AUTOR               DESCRIPCION
     =========           =========            ====================
     08/05/2024          Adrianavg            OSF-2668: Se migra del esquema OPEN al esquema ADM_PERSON
     20/06/2024          jpinedc              OSF-2606: * Se usa pkg_Correo
                                              * Ajustes por estándares
    ***************************************************************************/
    csbMetodo        CONSTANT VARCHAR2(70) := 'adm_person.ldc_procgenproyemadcareta';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    CURSOR curvalores (plazo NUMBER)
    IS
        SELECT etapa, capital, interes
          FROM (  SELECT edad_deuda                 etapa,
                         SUM (NVL (capital, 0))     capital,
                         SUM (NVL (interes, 0))     interes
                    FROM ldc_proyrecareta_temp
                   WHERE nucuota_i = plazO AND ANO = inano AND mes = inmes
                GROUP BY edad_deuda);

    CURSOR cucartetapa1 IS
        SELECT SUM (DECODE (concepto, 1, valor, 0))     capital,
               SUM (DECODE (concepto, 2, valor, 0))     interes,
               SUM (DECODE (concepto, 4, valor, 0))     seguro,
               SUM (DECODE (concepto, 3, valor, 0))     mora
          FROM (  SELECT CASE
                             WHEN caccconc NOT IN (                   /*MORA*/
                                                   220,
                                                   285           /*INTERESES*/
                                                      ,
                                                   132,
                                                   136,
                                                   245,
                                                   282,
                                                   332,
                                                   333,
                                                   373,
                                                   488,
                                                   511,
                                                   673,
                                                   756,
                                                   759,
                                                   131,
                                                   132,
                                                   133,
                                                   134,
                                                   135,
                                                   136,
                                                   281,
                                                   282,
                                                   283,
                                                   294,
                                                   --  295,
                                                   296,
                                                   --  297,
                                                   298,
                                                   299,
                                                   300,
                                                   302,
                                                   303,
                                                   373,
                                                   626,
                                                   635,
                                                   672,
                                                   673,
                                                   756,
                                                   759,
                                                   760,
                                                   761,
                                                   762              /*SEGURO*/
                                                      ,
                                                   120,
                                                   139,
                                                   177,
                                                   179,
                                                   180,
                                                   181,
                                                   183,
                                                   185)
                             THEN
                                 '1'                                 --capital
                             WHEN caccconc IN (                  /*INTERESES*/
                                               132,
                                               136,
                                               245,
                                               282,
                                               332,
                                               333,
                                               373,
                                               488,
                                               511,
                                               673,
                                               756,
                                               759,
                                               131,
                                               132,
                                               133,
                                               134,
                                               135,
                                               136,
                                               281,
                                               282,
                                               283,
                                               294,
                                               --     295,
                                               296,
                                               --    297,
                                               298,
                                               299,
                                               300,
                                               302,
                                               303,
                                               373,
                                               626,
                                               635,
                                               672,
                                               673,
                                               756,
                                               759,
                                               760,
                                               761,
                                               762)
                             THEN
                                 '2'                                 --interes
                             WHEN caccconc IN (                       /*MORA*/
                                               220, 285)
                             THEN
                                 '3'                                    --mora
                             WHEN caccconc IN (                     /*SEGURO*/
                                               120,
                                               139,
                                               177,
                                               179,
                                               180,
                                               181,
                                               183,
                                               185)
                             THEN
                                 '4'                                  --seguro
                         END                 concepto,
                         SUM (j.caccsape)    valor
                    FROM ic_cartcoco j, ldc_osf_Sesucier s
                   WHERE     j.caccfege =
                             (SELECT TRUNC (fc.cicofech)
                                FROM ldc_ciercome fc
                               WHERE fc.cicoano = inano AND fc.cicomes = inmes)
                         AND j.caccnuse = s.producto
                         AND s.nuano = inano
                         AND s.numes = inmes
                         AND s.edad < 30
                         AND caccserv = inservicio
                GROUP BY CASE
                             WHEN caccconc NOT IN (                   /*MORA*/
                                                   220,
                                                   285           /*INTERESES*/
                                                      ,
                                                   132,
                                                   136,
                                                   245,
                                                   282,
                                                   332,
                                                   333,
                                                   373,
                                                   488,
                                                   511,
                                                   673,
                                                   756,
                                                   759,
                                                   131,
                                                   132,
                                                   133,
                                                   134,
                                                   135,
                                                   136,
                                                   281,
                                                   282,
                                                   283,
                                                   294,
                                                   --    295,
                                                   296,
                                                   --    297,
                                                   298,
                                                   299,
                                                   300,
                                                   302,
                                                   303,
                                                   373,
                                                   626,
                                                   635,
                                                   672,
                                                   673,
                                                   756,
                                                   759,
                                                   760,
                                                   761,
                                                   762              /*SEGURO*/
                                                      ,
                                                   120,
                                                   139,
                                                   177,
                                                   179,
                                                   180,
                                                   181,
                                                   183,
                                                   185)
                             THEN
                                 '1'                                 --capital
                             WHEN caccconc IN (                  /*INTERESES*/
                                               132,
                                               136,
                                               245,
                                               282,
                                               332,
                                               333,
                                               373,
                                               488,
                                               511,
                                               673,
                                               756,
                                               759,
                                               131,
                                               132,
                                               133,
                                               134,
                                               135,
                                               136,
                                               281,
                                               282,
                                               283,
                                               294,
                                               --     295,
                                               296,
                                               --     297,
                                               298,
                                               299,
                                               300,
                                               302,
                                               303,
                                               373,
                                               626,
                                               635,
                                               672,
                                               673,
                                               756,
                                               759,
                                               760,
                                               761,
                                               762)
                             THEN
                                 '2'                                 --interes
                             WHEN caccconc IN (                       /*MORA*/
                                               220, 285)
                             THEN
                                 '3'                                    --mora
                             WHEN caccconc IN (                     /*SEGURO*/
                                               120,
                                               139,
                                               177,
                                               179,
                                               180,
                                               181,
                                               183,
                                               185)
                             THEN
                                 '4'                                  --seguro
                         END);

    CURSOR cucartetapa2a IS
        SELECT SUM (DECODE (concepto, 1, valor, 0))     capital,
               SUM (DECODE (concepto, 2, valor, 0))     interes,
               SUM (DECODE (concepto, 4, valor, 0))     seguro,
               SUM (DECODE (concepto, 3, valor, 0))     mora
          FROM (  SELECT CASE
                             WHEN caccconc NOT IN (                   /*MORA*/
                                                   220,
                                                   285           /*INTERESES*/
                                                      ,
                                                   132,
                                                   136,
                                                   245,
                                                   282,
                                                   332,
                                                   333,
                                                   373,
                                                   488,
                                                   511,
                                                   673,
                                                   756,
                                                   759,
                                                   131,
                                                   132,
                                                   133,
                                                   134,
                                                   135,
                                                   136,
                                                   281,
                                                   282,
                                                   283,
                                                   294,
                                                   --  295,
                                                   296,
                                                   --  297,
                                                   298,
                                                   299,
                                                   300,
                                                   302,
                                                   303,
                                                   373,
                                                   626,
                                                   635,
                                                   672,
                                                   673,
                                                   756,
                                                   759,
                                                   760,
                                                   761,
                                                   762              /*SEGURO*/
                                                      ,
                                                   120,
                                                   139,
                                                   177,
                                                   179,
                                                   180,
                                                   181,
                                                   183,
                                                   185)
                             THEN
                                 '1'                                 --capital
                             WHEN caccconc IN (                  /*INTERESES*/
                                               132,
                                               136,
                                               245,
                                               282,
                                               332,
                                               333,
                                               373,
                                               488,
                                               511,
                                               673,
                                               756,
                                               759,
                                               131,
                                               132,
                                               133,
                                               134,
                                               135,
                                               136,
                                               281,
                                               282,
                                               283,
                                               294,
                                               --     295,
                                               296,
                                               --    297,
                                               298,
                                               299,
                                               300,
                                               302,
                                               303,
                                               373,
                                               626,
                                               635,
                                               672,
                                               673,
                                               756,
                                               759,
                                               760,
                                               761,
                                               762)
                             THEN
                                 '2'                                 --interes
                             WHEN caccconc IN (                       /*MORA*/
                                               220, 285)
                             THEN
                                 '3'                                    --mora
                             WHEN caccconc IN (                     /*SEGURO*/
                                               120,
                                               139,
                                               177,
                                               179,
                                               180,
                                               181,
                                               183,
                                               185)
                             THEN
                                 '4'                                  --seguro
                         END                 concepto,
                         SUM (j.caccsape)    valor
                    FROM ic_cartcoco j, ldc_osf_Sesucier s
                   WHERE     j.caccfege =
                             (SELECT TRUNC (fc.cicofech)
                                FROM ldc_ciercome fc
                               WHERE fc.cicoano = inano AND fc.cicomes = inmes)
                         AND j.caccnuse = s.producto
                         AND s.nuano = inano
                         AND s.numes = inmes
                         AND s.edad >= 30
                         AND s.edad <= 60
                         AND caccserv = inservicio
                GROUP BY CASE
                             WHEN caccconc NOT IN (                   /*MORA*/
                                                   220,
                                                   285           /*INTERESES*/
                                                      ,
                                                   132,
                                                   136,
                                                   245,
                                                   282,
                                                   332,
                                                   333,
                                                   373,
                                                   488,
                                                   511,
                                                   673,
                                                   756,
                                                   759,
                                                   131,
                                                   132,
                                                   133,
                                                   134,
                                                   135,
                                                   136,
                                                   281,
                                                   282,
                                                   283,
                                                   294,
                                                   --    295,
                                                   296,
                                                   --    297,
                                                   298,
                                                   299,
                                                   300,
                                                   302,
                                                   303,
                                                   373,
                                                   626,
                                                   635,
                                                   672,
                                                   673,
                                                   756,
                                                   759,
                                                   760,
                                                   761,
                                                   762              /*SEGURO*/
                                                      ,
                                                   120,
                                                   139,
                                                   177,
                                                   179,
                                                   180,
                                                   181,
                                                   183,
                                                   185)
                             THEN
                                 '1'                                 --capital
                             WHEN caccconc IN (                  /*INTERESES*/
                                               132,
                                               136,
                                               245,
                                               282,
                                               332,
                                               333,
                                               373,
                                               488,
                                               511,
                                               673,
                                               756,
                                               759,
                                               131,
                                               132,
                                               133,
                                               134,
                                               135,
                                               136,
                                               281,
                                               282,
                                               283,
                                               294,
                                               --     295,
                                               296,
                                               --     297,
                                               298,
                                               299,
                                               300,
                                               302,
                                               303,
                                               373,
                                               626,
                                               635,
                                               672,
                                               673,
                                               756,
                                               759,
                                               760,
                                               761,
                                               762)
                             THEN
                                 '2'                                 --interes
                             WHEN caccconc IN (                       /*MORA*/
                                               220, 285)
                             THEN
                                 '3'                                    --mora
                             WHEN caccconc IN (                     /*SEGURO*/
                                               120,
                                               139,
                                               177,
                                               179,
                                               180,
                                               181,
                                               183,
                                               185)
                             THEN
                                 '4'                                  --seguro
                         END);

    CURSOR cucartetapa2b IS
        SELECT SUM (DECODE (concepto, 1, valor, 0))     capital,
               SUM (DECODE (concepto, 2, valor, 0))     interes,
               SUM (DECODE (concepto, 4, valor, 0))     seguro,
               SUM (DECODE (concepto, 3, valor, 0))     mora
          FROM (  SELECT CASE
                             WHEN caccconc NOT IN (                   /*MORA*/
                                                   220,
                                                   285           /*INTERESES*/
                                                      ,
                                                   132,
                                                   136,
                                                   245,
                                                   282,
                                                   332,
                                                   333,
                                                   373,
                                                   488,
                                                   511,
                                                   673,
                                                   756,
                                                   759,
                                                   131,
                                                   132,
                                                   133,
                                                   134,
                                                   135,
                                                   136,
                                                   281,
                                                   282,
                                                   283,
                                                   294,
                                                   --  295,
                                                   296,
                                                   --  297,
                                                   298,
                                                   299,
                                                   300,
                                                   302,
                                                   303,
                                                   373,
                                                   626,
                                                   635,
                                                   672,
                                                   673,
                                                   756,
                                                   759,
                                                   760,
                                                   761,
                                                   762              /*SEGURO*/
                                                      ,
                                                   120,
                                                   139,
                                                   177,
                                                   179,
                                                   180,
                                                   181,
                                                   183,
                                                   185)
                             THEN
                                 '1'                                 --capital
                             WHEN caccconc IN (                  /*INTERESES*/
                                               132,
                                               136,
                                               245,
                                               282,
                                               332,
                                               333,
                                               373,
                                               488,
                                               511,
                                               673,
                                               756,
                                               759,
                                               131,
                                               132,
                                               133,
                                               134,
                                               135,
                                               136,
                                               281,
                                               282,
                                               283,
                                               294,
                                               --     295,
                                               296,
                                               --    297,
                                               298,
                                               299,
                                               300,
                                               302,
                                               303,
                                               373,
                                               626,
                                               635,
                                               672,
                                               673,
                                               756,
                                               759,
                                               760,
                                               761,
                                               762)
                             THEN
                                 '2'                                 --interes
                             WHEN caccconc IN (                       /*MORA*/
                                               220, 285)
                             THEN
                                 '3'                                    --mora
                             WHEN caccconc IN (                     /*SEGURO*/
                                               120,
                                               139,
                                               177,
                                               179,
                                               180,
                                               181,
                                               183,
                                               185)
                             THEN
                                 '4'                                  --seguro
                         END                 concepto,
                         SUM (j.caccsape)    valor
                    FROM ic_cartcoco j, ldc_osf_Sesucier s
                   WHERE     j.caccfege =
                             (SELECT TRUNC (fc.cicofech)
                                FROM ldc_ciercome fc
                               WHERE fc.cicoano = inano AND fc.cicomes = inmes)
                         AND j.caccnuse = s.producto
                         AND s.nuano = inano
                         AND s.numes = inmes
                         AND s.edad > 60
                         AND s.edad <= 90
                         AND caccserv = inservicio
                GROUP BY CASE
                             WHEN caccconc NOT IN (                   /*MORA*/
                                                   220,
                                                   285           /*INTERESES*/
                                                      ,
                                                   132,
                                                   136,
                                                   245,
                                                   282,
                                                   332,
                                                   333,
                                                   373,
                                                   488,
                                                   511,
                                                   673,
                                                   756,
                                                   759,
                                                   131,
                                                   132,
                                                   133,
                                                   134,
                                                   135,
                                                   136,
                                                   281,
                                                   282,
                                                   283,
                                                   294,
                                                   --    295,
                                                   296,
                                                   --    297,
                                                   298,
                                                   299,
                                                   300,
                                                   302,
                                                   303,
                                                   373,
                                                   626,
                                                   635,
                                                   672,
                                                   673,
                                                   756,
                                                   759,
                                                   760,
                                                   761,
                                                   762              /*SEGURO*/
                                                      ,
                                                   120,
                                                   139,
                                                   177,
                                                   179,
                                                   180,
                                                   181,
                                                   183,
                                                   185)
                             THEN
                                 '1'                                 --capital
                             WHEN caccconc IN (                  /*INTERESES*/
                                               132,
                                               136,
                                               245,
                                               282,
                                               332,
                                               333,
                                               373,
                                               488,
                                               511,
                                               673,
                                               756,
                                               759,
                                               131,
                                               132,
                                               133,
                                               134,
                                               135,
                                               136,
                                               281,
                                               282,
                                               283,
                                               294,
                                               --     295,
                                               296,
                                               --     297,
                                               298,
                                               299,
                                               300,
                                               302,
                                               303,
                                               373,
                                               626,
                                               635,
                                               672,
                                               673,
                                               756,
                                               759,
                                               760,
                                               761,
                                               762)
                             THEN
                                 '2'                                 --interes
                             WHEN caccconc IN (                       /*MORA*/
                                               220, 285)
                             THEN
                                 '3'                                    --mora
                             WHEN caccconc IN (                     /*SEGURO*/
                                               120,
                                               139,
                                               177,
                                               179,
                                               180,
                                               181,
                                               183,
                                               185)
                             THEN
                                 '4'                                  --seguro
                         END);

    CURSOR cucartetapa3a IS
        SELECT SUM (DECODE (concepto, 1, valor, 0))     capital,
               SUM (DECODE (concepto, 2, valor, 0))     interes,
               SUM (DECODE (concepto, 4, valor, 0))     seguro,
               SUM (DECODE (concepto, 3, valor, 0))     mora
          FROM (  SELECT CASE
                             WHEN caccconc NOT IN (                   /*MORA*/
                                                   220,
                                                   285           /*INTERESES*/
                                                      ,
                                                   132,
                                                   136,
                                                   245,
                                                   282,
                                                   332,
                                                   333,
                                                   373,
                                                   488,
                                                   511,
                                                   673,
                                                   756,
                                                   759,
                                                   131,
                                                   132,
                                                   133,
                                                   134,
                                                   135,
                                                   136,
                                                   281,
                                                   282,
                                                   283,
                                                   294,
                                                   --  295,
                                                   296,
                                                   --  297,
                                                   298,
                                                   299,
                                                   300,
                                                   302,
                                                   303,
                                                   373,
                                                   626,
                                                   635,
                                                   672,
                                                   673,
                                                   756,
                                                   759,
                                                   760,
                                                   761,
                                                   762              /*SEGURO*/
                                                      ,
                                                   120,
                                                   139,
                                                   177,
                                                   179,
                                                   180,
                                                   181,
                                                   183,
                                                   185)
                             THEN
                                 '1'                                 --capital
                             WHEN caccconc IN (                  /*INTERESES*/
                                               132,
                                               136,
                                               245,
                                               282,
                                               332,
                                               333,
                                               373,
                                               488,
                                               511,
                                               673,
                                               756,
                                               759,
                                               131,
                                               132,
                                               133,
                                               134,
                                               135,
                                               136,
                                               281,
                                               282,
                                               283,
                                               294,
                                               --     295,
                                               296,
                                               --    297,
                                               298,
                                               299,
                                               300,
                                               302,
                                               303,
                                               373,
                                               626,
                                               635,
                                               672,
                                               673,
                                               756,
                                               759,
                                               760,
                                               761,
                                               762)
                             THEN
                                 '2'                                 --interes
                             WHEN caccconc IN (                       /*MORA*/
                                               220, 285)
                             THEN
                                 '3'                                    --mora
                             WHEN caccconc IN (                     /*SEGURO*/
                                               120,
                                               139,
                                               177,
                                               179,
                                               180,
                                               181,
                                               183,
                                               185)
                             THEN
                                 '4'                                  --seguro
                         END                 concepto,
                         SUM (j.caccsape)    valor
                    FROM ic_cartcoco j, ldc_osf_Sesucier s
                   WHERE     j.caccfege =
                             (SELECT TRUNC (fc.cicofech)
                                FROM ldc_ciercome fc
                               WHERE fc.cicoano = inano AND fc.cicomes = inmes)
                         AND j.caccnuse = s.producto
                         AND s.edad > 90
                         AND s.edad <= 180
                         AND s.nuano = inano
                         AND s.numes = inmes
                         AND caccserv = inservicio
                GROUP BY CASE
                             WHEN caccconc NOT IN (                   /*MORA*/
                                                   220,
                                                   285           /*INTERESES*/
                                                      ,
                                                   132,
                                                   136,
                                                   245,
                                                   282,
                                                   332,
                                                   333,
                                                   373,
                                                   488,
                                                   511,
                                                   673,
                                                   756,
                                                   759,
                                                   131,
                                                   132,
                                                   133,
                                                   134,
                                                   135,
                                                   136,
                                                   281,
                                                   282,
                                                   283,
                                                   294,
                                                   --    295,
                                                   296,
                                                   --    297,
                                                   298,
                                                   299,
                                                   300,
                                                   302,
                                                   303,
                                                   373,
                                                   626,
                                                   635,
                                                   672,
                                                   673,
                                                   756,
                                                   759,
                                                   760,
                                                   761,
                                                   762              /*SEGURO*/
                                                      ,
                                                   120,
                                                   139,
                                                   177,
                                                   179,
                                                   180,
                                                   181,
                                                   183,
                                                   185)
                             THEN
                                 '1'                                 --capital
                             WHEN caccconc IN (                  /*INTERESES*/
                                               132,
                                               136,
                                               245,
                                               282,
                                               332,
                                               333,
                                               373,
                                               488,
                                               511,
                                               673,
                                               756,
                                               759,
                                               131,
                                               132,
                                               133,
                                               134,
                                               135,
                                               136,
                                               281,
                                               282,
                                               283,
                                               294,
                                               --     295,
                                               296,
                                               --     297,
                                               298,
                                               299,
                                               300,
                                               302,
                                               303,
                                               373,
                                               626,
                                               635,
                                               672,
                                               673,
                                               756,
                                               759,
                                               760,
                                               761,
                                               762)
                             THEN
                                 '2'                                 --interes
                             WHEN caccconc IN (                       /*MORA*/
                                               220, 285)
                             THEN
                                 '3'                                    --mora
                             WHEN caccconc IN (                     /*SEGURO*/
                                               120,
                                               139,
                                               177,
                                               179,
                                               180,
                                               181,
                                               183,
                                               185)
                             THEN
                                 '4'                                  --seguro
                         END);

    CURSOR cucartetapa3b IS
        SELECT SUM (DECODE (concepto, 1, valor, 0))     capital,
               SUM (DECODE (concepto, 2, valor, 0))     interes,
               SUM (DECODE (concepto, 4, valor, 0))     seguro,
               SUM (DECODE (concepto, 3, valor, 0))     mora
          FROM (  SELECT CASE
                             WHEN caccconc NOT IN (                   /*MORA*/
                                                   220,
                                                   285           /*INTERESES*/
                                                      ,
                                                   132,
                                                   136,
                                                   245,
                                                   282,
                                                   332,
                                                   333,
                                                   373,
                                                   488,
                                                   511,
                                                   673,
                                                   756,
                                                   759,
                                                   131,
                                                   132,
                                                   133,
                                                   134,
                                                   135,
                                                   136,
                                                   281,
                                                   282,
                                                   283,
                                                   294,
                                                   --  295,
                                                   296,
                                                   --  297,
                                                   298,
                                                   299,
                                                   300,
                                                   302,
                                                   303,
                                                   373,
                                                   626,
                                                   635,
                                                   672,
                                                   673,
                                                   756,
                                                   759,
                                                   760,
                                                   761,
                                                   762              /*SEGURO*/
                                                      ,
                                                   120,
                                                   139,
                                                   177,
                                                   179,
                                                   180,
                                                   181,
                                                   183,
                                                   185)
                             THEN
                                 '1'                                 --capital
                             WHEN caccconc IN (                  /*INTERESES*/
                                               132,
                                               136,
                                               245,
                                               282,
                                               332,
                                               333,
                                               373,
                                               488,
                                               511,
                                               673,
                                               756,
                                               759,
                                               131,
                                               132,
                                               133,
                                               134,
                                               135,
                                               136,
                                               281,
                                               282,
                                               283,
                                               294,
                                               --     295,
                                               296,
                                               --    297,
                                               298,
                                               299,
                                               300,
                                               302,
                                               303,
                                               373,
                                               626,
                                               635,
                                               672,
                                               673,
                                               756,
                                               759,
                                               760,
                                               761,
                                               762)
                             THEN
                                 '2'                                 --interes
                             WHEN caccconc IN (                       /*MORA*/
                                               220, 285)
                             THEN
                                 '3'                                    --mora
                             WHEN caccconc IN (                     /*SEGURO*/
                                               120,
                                               139,
                                               177,
                                               179,
                                               180,
                                               181,
                                               183,
                                               185)
                             THEN
                                 '4'                                  --seguro
                         END                 concepto,
                         SUM (j.caccsape)    valor
                    FROM ic_cartcoco j, ldc_osf_Sesucier s
                   WHERE     j.caccfege =
                             (SELECT TRUNC (fc.cicofech)
                                FROM ldc_ciercome fc
                               WHERE fc.cicoano = inano AND fc.cicomes = inmes)
                         AND j.caccnuse = s.producto
                         AND s.edad > 180
                         AND s.nuano = inano
                         AND s.numes = inmes
                         AND caccserv = inservicio
                GROUP BY CASE
                             WHEN caccconc NOT IN (                   /*MORA*/
                                                   220,
                                                   285           /*INTERESES*/
                                                      ,
                                                   132,
                                                   136,
                                                   245,
                                                   282,
                                                   332,
                                                   333,
                                                   373,
                                                   488,
                                                   511,
                                                   673,
                                                   756,
                                                   759,
                                                   131,
                                                   132,
                                                   133,
                                                   134,
                                                   135,
                                                   136,
                                                   281,
                                                   282,
                                                   283,
                                                   294,
                                                   --    295,
                                                   296,
                                                   --    297,
                                                   298,
                                                   299,
                                                   300,
                                                   302,
                                                   303,
                                                   373,
                                                   626,
                                                   635,
                                                   672,
                                                   673,
                                                   756,
                                                   759,
                                                   760,
                                                   761,
                                                   762              /*SEGURO*/
                                                      ,
                                                   120,
                                                   139,
                                                   177,
                                                   179,
                                                   180,
                                                   181,
                                                   183,
                                                   185)
                             THEN
                                 '1'                                 --capital
                             WHEN caccconc IN (                  /*INTERESES*/
                                               132,
                                               136,
                                               245,
                                               282,
                                               332,
                                               333,
                                               373,
                                               488,
                                               511,
                                               673,
                                               756,
                                               759,
                                               131,
                                               132,
                                               133,
                                               134,
                                               135,
                                               136,
                                               281,
                                               282,
                                               283,
                                               294,
                                               --     295,
                                               296,
                                               --     297,
                                               298,
                                               299,
                                               300,
                                               302,
                                               303,
                                               373,
                                               626,
                                               635,
                                               672,
                                               673,
                                               756,
                                               759,
                                               760,
                                               761,
                                               762)
                             THEN
                                 '2'                                 --interes
                             WHEN caccconc IN (                       /*MORA*/
                                               220, 285)
                             THEN
                                 '3'                                    --mora
                             WHEN caccconc IN (                     /*SEGURO*/
                                               120,
                                               139,
                                               177,
                                               179,
                                               180,
                                               181,
                                               183,
                                               185)
                             THEN
                                 '4'                                  --seguro
                         END);

    nusession    NUMBER;
    sbperi       VARCHAR2 (100);
    mes          VARCHAR2 (30);
    varano       INTEGER := inano;
    varmes       INTEGER := inmes;
    fecha        DATE;

    capital      NUMBER;
    cp           NUMBER;
    max_cuota    NUMBER;
    tasa         NUMBER;
    cuotas       NUMBER;
    intereses    NUMBER;
    tasa_int     NUMBER;

    nurecargo    NUMBER;

    vcap0        NUMBER;
    vcap1        NUMBER;
    vcap2        NUMBER;
    vcap3        NUMBER;
    vcap4        NUMBER;
    vcap5        NUMBER;
    vcap6        NUMBER;

    vint0        NUMBER;
    vint1        NUMBER;
    vint2        NUMBER;
    vint3        NUMBER;
    vint4        NUMBER;
    vint5        NUMBER;
    vint6        NUMBER;
    nuconta      NUMBER (10);

    vCarCap      NUMBER;
    vCarInt      NUMBER;
    vCarSeg      NUMBER;
    
    vrec0        NUMBER;
    vrec1        NUMBER;
    vrec2        NUMBER;
    vrec3        NUMBER;
    vrec4        NUMBER;
    vrec5        NUMBER;
    vrec6        NUMBER;

    vPIint7      NUMBER;
    vPIint8      NUMBER;
    vPIint9      NUMBER;
    vPIint10     NUMBER;

    m11          NUMBER;
    m12          NUMBER;
    m13          NUMBER;
    m21          NUMBER;
    m22          NUMBER;
    m23          NUMBER;
    m31          NUMBER;
    m32          NUMBER;
    m33          NUMBER;

    colTCCM      NUMBER;

    tf1          NUMBER := 0;
    tf2          NUMBER := 0;
    tf3          NUMBER := 0;

    ma1          NUMBER := 0;
    mb1          NUMBER := 0;
    mc1          NUMBER := 0;
    md1          NUMBER := 0;
    me1          NUMBER := 0;

    ma3          NUMBER := 0;
    mb3          NUMBER := 0;
    mc3          NUMBER := 0;
    md3          NUMBER := 0;
    me3          NUMBER := 0;

    ma2          NUMBER := 0;
    mb2          NUMBER := 0;
    mc2          NUMBER := 0;
    md2          NUMBER := 0;
    me2          NUMBER := 0;
    m14          NUMBER := 0;                           -- entre 13 y 36 meses
    m15          NUMBER := 0;                           -- entre 37 y 60 meses
    m16          NUMBER := 0;                          -- entre 61 meses y mas

    m24          NUMBER := 0;                           -- entre 13 y 36 meses
    m25          NUMBER := 0;                           -- entre 37 y 60 meses
    m26          NUMBER := 0;                          -- entre 61 meses y mas

    m34          NUMBER := 0;                           -- entre 13 y 36 meses
    m35          NUMBER := 0;                           -- entre 37 y 60 meses
    m36          NUMBER := 0;                          -- entre 61 meses y mas

    sbDestinatarios       VARCHAR2 (2000);
    sbAsunto    VARCHAR2 (255) := '';


    vcap0_e1     NUMBER := 0;
    vint0_e1     NUMBER := 0;
    vcap0_e2     NUMBER := 0;
    vint0_e2     NUMBER := 0;
    vcap0_e3     NUMBER := 0;
    vint0_e3     NUMBER := 0;

    vcap6_e1     NUMBER := 0;
    vint6_e1     NUMBER := 0;
    vcap6_e2     NUMBER := 0;
    vint6_e2     NUMBER := 0;
    vcap6_e3     NUMBER := 0;
    vint6_e3     NUMBER := 0;

    TFCAP1       NUMBER := 0;
    TFINT1       NUMBER := 0;
    TFSEG1       NUMBER := 0;
    TFMOR1       NUMBER := 0;
    TFCAP2       NUMBER := 0;
    TFINT2       NUMBER := 0;
    TFSEG2       NUMBER := 0;
    TFMOR2       NUMBER := 0;
    TFCAP3       NUMBER := 0;
    TFINT3       NUMBER := 0;
    TFSEG3       NUMBER := 0;
    TFMOR3       NUMBER := 0;

    TFCAP2A      NUMBER := 0;
    TFINT2A      NUMBER := 0;
    TFSEG2A      NUMBER := 0;
    TFMOR2A      NUMBER := 0;
    TFCAP3A      NUMBER := 0;
    TFINT3A      NUMBER := 0;
    TFSEG3A      NUMBER := 0;
    TFMOR3A      NUMBER := 0;

    TFCAP2B      NUMBER := 0;
    TFINT2B      NUMBER := 0;
    TFSEG2B      NUMBER := 0;
    TFMOR2B      NUMBER := 0;
    TFCAP3B      NUMBER := 0;
    TFINT3B      NUMBER := 0;
    TFSEG3B      NUMBER := 0;
    TFMOR3B      NUMBER := 0;
    
     sbproceso  VARCHAR2(100) := 'LDCRMADCARETA'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
     
BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 

    sbDestinatarios := pkg_BCLD_Parameter.fsbObtieneValorCadena('MAILRMADCARETA');

    IF sbDestinatarios IS NOT NULL
    THEN
        sbAsunto :=
            'Notificacion: Procesos REPORTE MADURACION DE CARTERA POR ETAPA (LDCRMADCAR)';

        pkg_Correo.prcEnviaCorreo
        (
            isbDestinatarios    => sbDestinatarios,
            isbAsunto           => sbAsunto,
            isbMensaje          => 'Inicia La ejecucion del Proceso: LDCRMADCAR CON PARAMETROS ANO='
            || TO_CHAR (INANO)
            || ' MES='
            || TO_CHAR (INMES)
            || ' TIPO PRODUCTO='
            || TO_CHAR (INSERVICIO)
        );            
            
    END IF;


    vcap0 := 0;
    vcap1 := 0;
    vcap2 := 0;
    vcap3 := 0;
    vcap4 := 0;
    vcap5 := 0;
    vcap6 := 0;

    vint0 := 0;
    vint1 := 0;
    vint2 := 0;
    vint3 := 0;
    vint4 := 0;
    vint5 := 0;
    vint6 := 0;
    nuconta := 0;

    vCarCap := 0;
    vCarInt := 0;
    vCarSeg := 0;
    vrec0 := 0;
    vrec1 := 0;
    vrec2 := 0;
    vrec3 := 0;
    vrec4 := 0;
    vrec5 := 0;
    vrec6 := 0;

    vPIint7 := 0;
    vPIint8 := 0;
    vPIint9 := 0;
    vPIint10 := 0;

    --  se agregan nuevas variables para los totales por etapas

    -- maduracion

    -- etapa 1
    m11 := 0;                                                 -- menor a 1 mes
    m12 := 0;                                             -- entre 2 y 6 meses
    m13 := 0;                                            -- entre 7 y 12 meses
    m14 := 0;                                           -- entre 13 y 36 meses
    m15 := 0;                                           -- entre 37 y 60 meses
    m16 := 0;                                          -- entre 61 meses y mas


    -- etapa 2
    m21 := 0;                                                 -- menor a 1 mes
    m22 := 0;                                             -- entre 2 y 6 meses
    m23 := 0;                                            -- entre 7 y 12 meses
    m24 := 0;                                           -- entre 13 y 36 meses
    m25 := 0;                                           -- entre 37 y 60 meses
    m26 := 0;                                          -- entre 61 meses y mas

    -- etapa 3
    m31 := 0;                                                 -- menor a 1 mes
    m32 := 0;                                             -- entre 2 y 6 meses
    m33 := 0;                                            -- entre 7 y 12 meses
    m34 := 0;                                           -- entre 13 y 36 meses
    m35 := 0;                                           -- entre 37 y 60 meses
    m36 := 0;                                          -- entre 61 meses y mas


    -- con riesgo

    colTCCM := 1;

    pkg_Traza.Trace('CARETA : VOY BORRAR Y LLENAR LDC_TEMP_SESUCARETA',csbNivelTraza);
    DELETE FROM LDC_TEMP_SESUCARETA;

    INSERT INTO LDC_TEMP_SESUCARETA (PRODUCTO,
                                     TIPO_PRODUCTO,
                                     EDAD,
                                     SESUSAPE,
                                     DEUDA_DIFERIDA_CORRIENTE,
                                     DEUDA_DIFERIDA_NO_CORRIENTE)
        SELECT PRODUCTO,
               TIPO_PRODUCTO,
               EDAD,
               SESUSAPE,
               DEUDA_DIFERIDA_CORRIENTE,
               DEUDA_DIFERIDA_NO_CORRIENTE
          FROM LDC_OSF_SESUCIER
         WHERE NUANO = INANO AND NUMES = INMES AND TIPO_PRODUCTO = INSERVICIO;

    pkg_Traza.Trace('CARETA : LLENE LDC_TEMP_SESUCARETA',csbNivelTraza);

    pkg_Traza.Trace('CARETA : VOY BORRAR Y LLENAR LDC_OSF_DIFERIDO_TEMP',csbNivelTraza);
    DELETE FROM LDC_OSF_DIFERIDO_TEMP;

    INSERT INTO LDC_OSF_DIFERIDO_TEMP (DIFEANO,
                                       DIFEMES,
                                       DIFENUCU,
                                       DIFECUPA,
                                       DIFENUSE,
                                       DIFESAPE,
                                       edad)
        SELECT DIFEANO,
               DIFEMES,
               DIFENUCU,
               DIFECUPA,
               DIFENUSE,
               DIFESAPE,
               EDAD
          FROM LDC_OSF_DIFERIDO, LDC_TEMP_SESUCARETA
         WHERE DIFEANO = INANO AND DIFEMES = INMES AND DIFENUSE = producto;

    COMMIT;

    pkg_Traza.Trace('CARETA : LLENE LDC_OSF_DIFERIDO_TEMP',csbNivelTraza);
    nusession := USERENV ('sessionid');

    pkg_EstaProc.prInsertaEstaProc( sbproceso, 1);

    pkg_Traza.Trace('CARETA : VOY BORRAR ldc_proyrecareta_temp',csbNivelTraza);
    DELETE FROM ldc_proyrecareta_temp
          WHERE ano = inano AND mes = inmes;

    pkg_Traza.Trace('CARETA : BORRE ldc_proyrecareta_temp',csbNivelTraza);
    pkg_Traza.Trace('CARETA : VOY BORRAR ldc_proyrecareta',csbNivelTraza);
    DELETE FROM ldc_proyrecareta
          WHERE ano = inano AND mes = inmes AND servICIO = inservicio;


    COMMIT;
    pkg_Traza.Trace('CARETA : BORRE ldc_proyrecareta',csbNivelTraza);
    fecha :=
        TO_DATE ('01' || LPAD (varmes, 2, '0') || varano,
                 'ddMMyyyy',
                 'NLS_DATE_LANGUAGE = SPANISH');

    mes := TRIM (TO_CHAR (fecha, 'Month', 'NLS_DATE_LANGUAGE = SPANISH'));

    SELECT cotiporc
      INTO tasa
      FROM conftain
     WHERE     cotitain = 2
           AND inano BETWEEN TO_CHAR (cotifein, 'YYYY')
                         AND TO_CHAR (cotifefi, 'YYYY')
           AND inmes BETWEEN TO_CHAR (cotifein, 'MM')
                         AND TO_CHAR (cotifefi, 'MM');

    tasa_int := (POWER (1 + (tasa / 100), 1 / 12) - 1);


    pkg_Traza.Trace('CARETA : VOY A CALCULAR MAX_CUOTA',csbNivelTraza);
    SELECT /*+ ALL_ROWS */
           MAX (difenucu - difecupa)
      INTO max_cuota
      FROM ldc_osf_diferido_temp J, LDC_TEMP_SESUCARETA M
     WHERE     J.difeano = inano
           AND J.difemes = inmes
           AND M.TIPO_PRODUCTO = inservicio
           AND J.difenuse = M.PRODUCTO;

    pkg_Traza.Trace('CARETA : CALCULE MAX_CUOTA='||TO_CHAR(MAX_CUOTA),csbNivelTraza);

    pkg_Traza.Trace('CARETA : VOY A LLENAR ldc_proyrecarETA_temp ETAPA 1 DE 1 A MAX_CUOTA',csbNivelTraza);

    -- CALCULA TEMPORALES DE ETAPA 1 QUE on las obligaciones con mora menor a 30 d?-as
    FOR i IN 1 .. max_cuota
    LOOP
        FOR j IN i .. max_cuota
        LOOP
            SELECT /*+ ALL_ROWS */
                   SUM (difesape)
              INTO cp
              FROM ldc_osf_diferido_temp
             WHERE     difeano = inano
                   AND difemes = inmes
                   AND difenucu - difecupa = j
                   AND EDAD < 30;

            capital := cp / j;

            intereses :=
                  capital
                * (  ((tasa_int) * POWER (1 + (tasa_int), j))
                   / (POWER (1 + (tasa_int), j - 1)));
            cuotas := capital - intereses;

            INSERT INTO ldc_proyrecarETA_temp (ano,
                                               mes,
                                               SERVICIO,
                                               nucuota_i,
                                               nucuOta_j,
                                               capital,
                                               cuota,
                                               interes,
                                               recargo,
                                               EDAD_DEUDA)
                 VALUES (inano,
                         inmes,
                         inservicio,
                         i,
                         j,
                         capital,
                         cuotas,
                         intereses,
                         nurecargo,
                         1);

            COMMIT;
            nuconta := nuconta + 1;
        END LOOP;

        UPDATE ldc_osf_estaproc l
           SET estado =
                      'Proceso ejecutandose. Registros procesados : '
                   || TO_CHAR (nuconta)
                   || ' espere a que termin? el proceso.'
         WHERE l.sesion = nusession AND l.proceso = 'LDCRMADCARETA';

        COMMIT;
    pkg_Traza.Trace('CARETA : LLENANDO ldc_proyrecarETA_temp ETAPA 1 DE 1 A MAX_CUOTA VOY POR LA '||TO_CHAR(I),csbNivelTraza);

    END LOOP;

    -- TERMINA DE LLENAR TEMPORAL CON LA ETAPA 1
    COMMIT;

    pkg_Traza.Trace('CARETA : VOY A LLENAR ldc_proyrecarETA_temp ETAPA 2 DE 1 A MAX_CUOTA',csbNivelTraza);

    -- CALCULA TEMPORALES DE Etapa 2 obligaciones con mora mayor o igual a 30 d?-as pero menor a 90 d?-as
    FOR i IN 1 .. max_cuota
    LOOP
        FOR j IN i .. max_cuota
        LOOP
            SELECT /*+ ALL_ROWS */
                   SUM (difesape)
              INTO cp
              FROM ldc_osf_diferido_temp
             WHERE     difeano = inano
                   AND difemes = inmes
                   AND difenucu - difecupa = j
                   /* and difenuse=70176074 --ojo*/
                   AND (EDAD >= 30 AND edad <= 90);

            capital := cp / j;

            intereses :=
                  capital
                * (  ((tasa_int) * POWER (1 + (tasa_int), j))
                   / (POWER (1 + (tasa_int), j - 1)));

            cuotas := capital - intereses;

            INSERT INTO ldc_proyrecarETA_temp (ano,
                                               mes,
                                               SERVICIO,
                                               nucuota_i,
                                               nucuOta_j,
                                               capital,
                                               cuota,
                                               interes,
                                               recargo,
                                               EDAD_DEUDA)
                 VALUES (inano,
                         inmes,
                         INSERVICIO,
                         i,
                         j,
                         capital,
                         cuotas,
                         intereses,
                         nurecargo,
                         2);

            COMMIT;
            nuconta := nuconta + 1;
        END LOOP;

        UPDATE ldc_osf_estaproc l
           SET estado =
                      'Proceso ejecutandose. Registros procesados : '
                   || TO_CHAR (nuconta)
                   || ' espere a que termin? el proceso.'
         WHERE l.sesion = nusession AND l.proceso = 'LDCRMADCARETA';

        COMMIT;
    pkg_Traza.Trace('CARETA : LLENANDO ldc_proyrecarETA_temp ETAPA 2 DE 1 A MAX_CUOTA VOY POR LA '||TO_CHAR(I),csbNivelTraza);
    END LOOP;

    -- TERMINA DE LLENAR TEMPORAL CON LA ETAPA 2
    COMMIT;

    pkg_Traza.Trace('CARETA : VOY A LLENAR ldc_proyrecarETA_temp ETAPA 3 DE 1 A MAX_CUOTA',csbNivelTraza);
    -- CALCULA TEMPORALES DE Etapa 3 obligaciones con mora mayor a 90 d?-as
    FOR i IN 1 .. max_cuota
    LOOP
        FOR j IN i .. max_cuota
        LOOP
            SELECT /*+ ALL_ROWS */
                   SUM (difesape)
              INTO cp
              FROM ldc_osf_diferido_temp
             WHERE     difeano = inano
                   AND difemes = inmes
                   AND difenucu - difecupa = j
                   AND (EDAD > 90);

            capital := cp / j;

            intereses :=
                  capital
                * (  ((tasa_int) * POWER (1 + (tasa_int), j))
                   / (POWER (1 + (tasa_int), j - 1)));

            cuotas := capital - intereses;

            INSERT INTO ldc_proyrecarETA_temp (ano,
                                               mes,
                                               SERVICIO,
                                               nucuota_i,
                                               nucuOta_j,
                                               capital,
                                               cuota,
                                               interes,
                                               recargo,
                                               EDAD_DEUDA)
                 VALUES (inano,
                         inmes,
                         INSERVICIO,
                         i,
                         j,
                         capital,
                         cuotas,
                         intereses,
                         nurecargo,
                         3);

            COMMIT;
            nuconta := nuconta + 1;
        END LOOP;

        UPDATE ldc_osf_estaproc l
           SET estado =
                      'Proceso ejecutandose. Registros procesados : '
                   || TO_CHAR (nuconta)
                   || ' espere a que termin? el proceso.'
         WHERE l.sesion = nusession AND l.proceso = 'LDCRMADCARETA';

        COMMIT;
    pkg_Traza.Trace('CARETA : LLENANDO ldc_proyrecarETA_temp ETAPA 3 DE 1 A MAX_CUOTA VOY POR LA '||TO_CHAR(I),csbNivelTraza);
    END LOOP;

    -- TERMINA DE LLENAR TEMPORAL CON LA ETAPA 3

    pkg_Traza.Trace('CARETA : TERMINE DE LLENAR ldc_proyrecarETA_temp',csbNivelTraza);

    pkg_Traza.Trace('CARETA : VOY A RECORRER CURVALORES '||TO_CHAR(MAX_CUOTA)||' VECES PARA LLENAR VARIABLES',csbNivelTraza);


    -------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------


    FOR a IN 1 .. max_cuota
    LOOP
        FOR u IN curvalores (a)
        LOOP
            IF u.etapa = 1
            THEN
                -- halla capital e interes proyectado al primer a?o
                IF a BETWEEN 0 AND 12
                THEN
                    vcap0_e1 := vcap0_e1 + u.capital;
                    vint0_e1 := vint0_e1 + u.interes;
                ELSE
                    vcap6_e1 := vcap6_e1 + u.capital;
                    vint6_e1 := vint6_e1 + u.interes;
                END IF;

                IF a BETWEEN 0 AND 1
                THEN
                    m11 := NVL (m11, 0) + u.capital + u.interes; -- menor igual a 1 mes
                END IF;



                IF a BETWEEN 2 AND 6
                THEN
                    m12 := NVL (m12, 0) + u.capital + u.interes; -- entre 2 y 6 meses
                END IF;

                IF a BETWEEN 7 AND 12
                THEN
                    m13 := NVL (m13, 0) + u.capital + u.interes; -- entre 7 y 12 meses
                END IF;

                IF a BETWEEN 13 AND 36
                THEN
                    m14 := NVL (m14, 0) + u.capital + u.interes; -- entre 13 y 36 meses
                END IF;

                IF a BETWEEN 37 AND 60
                THEN
                    m15 := NVL (m15, 0) + u.capital + u.interes; -- entre 37 y 60 meses
                END IF;

                IF a >= 61
                THEN
                    m16 := NVL (m16, 0) + u.capital + u.interes; -- entre 61 meses y mas
                END IF;
            END IF;

            IF u.etapa = 2
            THEN
                -- halla capital e interes proyectado al primer a?o
                IF a BETWEEN 0 AND 12
                THEN
                    vcap0_e2 := vcap0_e2 + u.capital;
                    vint0_e2 := vint0_e2 + u.interes;
                ELSE
                    vcap6_e2 := vcap6_e2 + u.capital;
                    vint6_e2 := vint6_e2 + u.interes;
                END IF;

                IF a BETWEEN 0 AND 1
                THEN
                    m21 := NVL (m21, 0) + u.capital + u.interes; -- menor igual a 1 mes
                END IF;



                IF a BETWEEN 2 AND 6
                THEN
                    m22 := NVL (m22, 0) + u.capital + u.interes; -- entre 2 y 6 meses
                END IF;

                IF a BETWEEN 7 AND 12
                THEN
                    m23 := NVL (m23, 0) + u.capital + u.interes; -- entre 7 y 12 meses
                END IF;

                IF a BETWEEN 13 AND 36
                THEN
                    m24 := NVL (m24, 0) + u.capital + u.interes; -- entre 13 y 36 meses
                END IF;

                IF a BETWEEN 37 AND 60
                THEN
                    m25 := NVL (m25, 0) + u.capital + u.interes; -- entre 37 y 60 meses
                END IF;

                IF a >= 61
                THEN
                    m26 := NVL (m26, 0) + u.capital + u.interes; -- entre 61 meses y mas
                END IF;
            END IF;

            IF u.etapa = 3
            THEN
                -- halla capital e interes proyectado al primer a?o
                IF a BETWEEN 0 AND 12
                THEN
                    vcap0_e3 := vcap0_e3 + u.capital;
                    vint0_e3 := vint0_e3 + u.interes;
                ELSE
                    vcap6_e3 := vcap6_e3 + u.capital;
                    vint6_e3 := vint6_e3 + u.interes;
                END IF;

                IF a BETWEEN 0 AND 1
                THEN
                    m31 := NVL (m31, 0) + u.capital + u.interes; -- menor igual a 1 mes
                END IF;



                IF a BETWEEN 2 AND 6
                THEN
                    m32 := NVL (m32, 0) + u.capital + u.interes; -- entre 2 y 6 meses
                END IF;

                IF a BETWEEN 7 AND 12
                THEN
                    m33 := NVL (m33, 0) + u.capital + u.interes; -- entre 7 y 12 meses
                END IF;

                IF a BETWEEN 13 AND 36
                THEN
                    m34 := NVL (m34, 0) + u.capital + u.interes; -- entre 13 y 36 meses
                END IF;

                IF a BETWEEN 37 AND 60
                THEN
                    m35 := NVL (m35, 0) + u.capital + u.interes; -- entre 37 y 60 meses
                END IF;

                IF a >= 61
                THEN
                    m36 := NVL (m36, 0) + u.capital + u.interes; -- entre 61 meses y mas
                END IF;
            END IF;
        END LOOP;

        nuconta := nuconta + 1;

        UPDATE ldc_osf_estaproc l
           SET estado =
                      'Proceso ejecutandose. Registros procesados : '
                   || TO_CHAR (nuconta)
                   || ' espere a que termin? el proceso.'
         WHERE l.sesion = nusession AND l.proceso = 'LDCRMADCARETA';

        COMMIT;
    pkg_Traza.Trace('CARETA : RECORRIENDO CURVALORES '||TO_CHAR(MAX_CUOTA)||' VECES VOY POR LA '||TO_CHAR(A),csbNivelTraza);

    END LOOP;

    pkg_Traza.Trace('CARETA : TERMINE DE RECORRER CURVALORES VOY A CALCULAR VARIABLES',csbNivelTraza);

    OPEN cucartetapa1;

    FETCH cucartetapa1
        INTO TFCAP1,
             TFINT1,
             TFSEG1,
             TFMOR1;

    IF cucartetapa1%NOTFOUND
    THEN
        TFCAP1 := 0;
        TFINT1 := 0;
        TFSEG1 := 0;
        TFMOR1 := 0;
    END IF;

    CLOSE cucartetapa1;

    TFCAP1 := NVL (TFCAP1, 0);
    TFINT1 := NVL (TFINT1, 0);
    TFSEG1 := NVL (TFSEG1, 0);
    TFMOR1 := NVL (TFMOR1, 0);


    OPEN cucartetapa2a;

    FETCH cucartetapa2a
        INTO TFCAP2A,
             TFINT2A,
             TFSEG2A,
             TFMOR2A;

    IF cucartetapa2a%NOTFOUND
    THEN
        TFCAP2A := 0;
        TFINT2A := 0;
        TFSEG2A := 0;
        TFMOR2A := 0;
    END IF;

    CLOSE cucartetapa2a;


    OPEN cucartetapa2b;

    FETCH cucartetapa2b
        INTO TFCAP2B,
             TFINT2B,
             TFSEG2B,
             TFMOR2B;

    IF cucartetapa2b%NOTFOUND
    THEN
        TFCAP2B := 0;
        TFINT2B := 0;
        TFSEG2B := 0;
        TFMOR2B := 0;
    END IF;

    CLOSE cucartetapa2b;

    TFCAP2A := NVL (TFCAP2A, 0);
    TFCAP2B := NVL (TFCAP2B, 0);
    TFSEG2A := NVL (TFSEG2A, 0);
    TFSEG2B := NVL (TFSEG2B, 0);
    TFINT2A := NVL (TFINT2A, 0);
    TFINT2B := NVL (TFINT2B, 0);
    TFMOR2A := NVL (TFMOR2A, 0);
    TFMOR2B := NVL (TFMOR2B, 0);

    TFCAP2 := TFCAP2A + TFCAP2B;
    TFINT2 := TFINT2A + TFINT2B;
    TFSEG2 := TFSEG2A + TFSEG2B;
    TFMOR2 := TFMOR2A + TFMOR2B;

    OPEN cucartetapa3a;

    FETCH cucartetapa3a
        INTO TFCAP3A,
             TFINT3A,
             TFSEG3A,
             TFMOR3A;

    IF cucartetapa3a%NOTFOUND
    THEN
        TFCAP3A := 0;
        TFINT3A := 0;
        TFSEG3A := 0;
        TFMOR3A := 0;
    END IF;

    CLOSE cucartetapa3a;

    OPEN cucartetapa3b;

    FETCH cucartetapa3b
        INTO TFCAP3B,
             TFINT3B,
             TFSEG3B,
             TFMOR3B;

    IF cucartetapa3b%NOTFOUND
    THEN
        TFCAP3B := 0;
        TFINT3B := 0;
        TFSEG3B := 0;
        TFMOR3B := 0;
    END IF;

    CLOSE cucartetapa3b;

    TFCAP3A := NVL (TFCAP3A, 0);
    TFCAP3B := NVL (TFCAP3B, 0);
    TFSEG3A := NVL (TFSEG3A, 0);
    TFSEG3B := NVL (TFSEG3B, 0);
    TFINT3A := NVL (TFINT3A, 0);
    TFINT3B := NVL (TFINT3B, 0);
    TFMOR3A := NVL (TFMOR3A, 0);
    TFMOR3B := NVL (TFMOR3B, 0);

    TFCAP3 := TFCAP3A + TFCAP3B;
    TFINT3 := TFINT3A + TFINT3B;
    TFSEG3 := TFSEG3A + TFSEG3B;
    TFMOR3 := TFMOR3A + TFMOR3B;

    -------------------------------

    -- Se incluye en el primer rango de proyecci?n (primeros 12 meses), la cartera corriente
    vcap0_e1 := vcap0_e1 + TFCAP1 - vcap0_e1 - vcap6_e1 + TFSEG1;       --lmfg
    vcap0_e2 := vcap0_e2 + TFCAP2 - vcap0_e2 - vcap6_e2 + TFSEG2;       --lmfg
    vcap0_e3 := vcap0_e3 + TFCAP3 - vcap0_e3 - vcap6_e3 + TFSEG3;       --lmfg

    IF TFINT1 = 0
    THEN
        vint0_e1 := 0;                                                  --lmfg
        vint6_e1 := 0;
    ELSE
        vint0_e1 := vint0_e1 + TFINT1 - vint0_e1 - vint6_e1;            --lmfg
    END IF;

    IF TFINT2 = 0
    THEN
        vint0_e2 := 0;                                                  --lmfg
        vint6_e2 := 0;
    ELSE
        vint0_e2 := vint0_e2 + TFINT2 - vint0_e2 - vint6_e2;            --lmfg
    END IF;

    IF TFINT3 = 0
    THEN
        vint0_e3 := 0;                                                  --lmfg
        vint6_e3 := 0;
    ELSE
        vint0_e3 := vint0_e3 + TFINT3 - vint0_e3 - vint6_e3;            --lmfg
    END IF;

    -------
    m11 := m11 + ((vcap0_e1 + vint0_e1 + TFMOR1) - (m11 + m12 + m13));
    m21 := m21 + ((vcap0_e2 + vint0_e2 + TFMOR2) - (m21 + m22 + m23));
    m31 := m31 + ((vcap0_e3 + vint0_e3 + TFMOR3) - (m31 + m32 + m33));
    -------

    tf1 := TFCAP1 + TFINT1 + TFSEG1 + TFMOR1;
    tf2 := TFCAP2 + TFINT2 + TFSEG2 + TFMOR2;
    tf3 := TFCAP3 + TFINT3 + TFSEG3 + TFMOR3;

    -- halla categorias
    ma1 := m11 + m12 + m13 + m14 + m15 + m16;
    mb1 := 0;
    mc1 := 0;
    md1 := 0;
    me1 := 0;

    ma2 := 0;
    mb2 := TFCAP2A + TFINT2A + TFSEG2A + TFMOR2A;
    mc2 := TFCAP2B + TFINT2B + TFSEG2B + TFMOR2B;
    md2 := 0;
    me2 := 0;

    ma3 := 0;
    mb3 := 0;
    mc3 := 0;
    md3 := TFCAP3A + TFINT3A + TFSEG3A + TFMOR3A;
    me3 := TFCAP3B + TFINT3B + TFSEG3B + TFMOR3B;

    -- inserta registro de etapa 1
    INSERT INTO ldc_proyrecareta (Ano,
                                  Mes,
                                  Servicio,
                                  Etapa,
                                  Valor,
                                  Menor1mes,
                                  Entre1y6mes,
                                  Entre6y12mes,
                                  Entre1y3a,
                                  Entre3y5a,
                                  Mayor5a,
                                  CategoriaA,
                                  CategoriaB,
                                  CategoriaC,
                                  CategoriaD,
                                  CategoriaE)
         VALUES (inano,
                 inmes,
                 inservicio,
                 1,
                 /*tf1+*/
                 m11 + m12 + m13 + m14 + m15 + m16,
                 m11 /*+tf1*/
                    ,
                 m12,
                 m13,
                 m14,
                 m15,
                 m16,
                 ma1,
                 mb1,
                 mc1,
                 md1,
                 me1);


    -- inserta registro de etapa 2
    INSERT INTO ldc_proyrecareta (Ano,
                                  Mes,
                                  Servicio,
                                  Etapa,
                                  Valor,
                                  Menor1mes,
                                  Entre1y6mes,
                                  Entre6y12mes,
                                  Entre1y3a,
                                  Entre3y5a,
                                  Mayor5a,
                                  CategoriaA,
                                  CategoriaB,
                                  CategoriaC,
                                  CategoriaD,
                                  CategoriaE)
         VALUES (inano,
                 inmes,
                 inservicio,
                 2,
                 /*tf2+*/
                 m21 + m22 + m23 + m24 + m25 + m26,
                 m21 /*+tf2*/
                    ,
                 m22,
                 m23,
                 m24,
                 m25,
                 m26,
                 ma2,
                 mb2,
                 mc2,
                 md2,
                 me2);


    -- inserta registro de etapa 3
    INSERT INTO ldc_proyrecareta (Ano,
                                  Mes,
                                  Servicio,
                                  Etapa,
                                  Valor,
                                  Menor1mes,
                                  Entre1y6mes,
                                  Entre6y12mes,
                                  Entre1y3a,
                                  Entre3y5a,
                                  Mayor5a,
                                  CategoriaA,
                                  CategoriaB,
                                  CategoriaC,
                                  CategoriaD,
                                  CategoriaE)
         VALUES (inano,
                 inmes,
                 inservicio,
                 3,
                 /*tf3+*/
                 m31 + m32 + m33 + m34 + m35 + m36,
                 m31 /*+tf3*/
                    ,
                 m32,
                 m33,
                 m34,
                 m35,
                 m36,
                 ma3,
                 mb3,
                 mc3,
                 md3,
                 me3);


    merro :=
           'Proceso termino Ok. Total registros procesados : '
        || TO_CHAR (nuconta)
        || '. (Servicio '
        || inservicio
        || ')';
        
    pkg_EstaProc.prActualizaEstaProc( sbproceso );

    COMMIT;

    pkg_Traza.Trace('CARETA : TERMINO PROCESO',csbNivelTraza);

    IF sbDestinatarios IS NOT NULL
    THEN
        sbAsunto :=
            'Notificacion: Procesos REPORTE MADURACION DE CARTERA POR ETAPA (LDCRMADCAR)';

        pkg_Correo.prcEnviaCorreo
        (
            isbDestinatarios    => sbDestinatarios,
            isbAsunto           => sbAsunto,
            isbMensaje          => 'Termina La ejecucion del Proceso: LDCRMADCAR CON PARAMETROS ANO='
            || TO_CHAR (INANO)
            || ' MES='
            || TO_CHAR (INMES)
            || ' TIPO PRODUCTO='
            || TO_CHAR (INSERVICIO)
            || '. Favor revise con el reporte ORM indicado'
        );
            
    END IF;
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);     
    
EXCEPTION
    WHEN OTHERS
    THEN
        merro :=
               'Error en LDCRMADCARETA (Servicio '
            || inservicio
            || ')'
            || SQLERRM;

        pkg_Traza.Trace('CARETA : SE PARTIO PROCESO '||SUBSTR(MERRO,1,500),csbNivelTraza);

        IF sbDestinatarios IS NOT NULL
        THEN
            sbAsunto :=
                'Notificacion: Procesos REPORTE MADURACION DE CARTERA POR ETAPA (LDCRMADCAR)';
                
            pkg_Correo.prcEnviaCorreo
            (
                isbDestinatarios    => sbDestinatarios,
                isbAsunto           => sbAsunto,
                isbMensaje          => 'Termina con errores la ejecucion del Proceso: LDCRMADCAR CON PARAMETROS ANO='
                || TO_CHAR (INANO)
                || ' MES='
                || TO_CHAR (INMES)
                || ' TIPO PRODUCTO='
                || TO_CHAR (INSERVICIO)
                || '. '
                || SUBSTR (MERRO, 1, 300)
            );                
                

        END IF;

        pkg_EstaProc.prActualizaEstaProc( isbProceso => sbproceso, isbObservacion => merro );
        
END LDC_PROCGENPROYEMADCARETA;
/

PROMPT OTORGA PERMISOS ESQUEMA sobre procedimiento LDC_PROCGENPROYEMADCARETA

BEGIN
    pkg_utilidades.prAplicarPermisos ('LDC_PROCGENPROYEMADCARETA',
                                      'ADM_PERSON');
END;
/