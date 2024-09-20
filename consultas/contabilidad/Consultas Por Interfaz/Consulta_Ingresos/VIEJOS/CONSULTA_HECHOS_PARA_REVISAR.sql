SELECT  To_Char(NVL((SELECT  CLASIFI_IVA  FROM OPEN.LDCI_CLASCONTIVA WHERE CLASIFICADOR=CONCCLCO),CONCCLCO))  AGRUPA,                   
        MOVITIHE TIPO_HECHO,  
        trunc(movifeco) FECHA,  
        CONCCLCO COD_CLASIFICADOR,   
        (select clcodesc from open.ic_clascont where clcocodi = CONCCLCO) DESC_CLASIFICA,  
        MOVICONC COD_CONCEPTO, OPEN.pktblconcepto.fsbgetconcdesc(MOVICONC) DESC_CONCEPTO,  
        MOVIUBG3||' - '||Decode(MOVIUBG3,NULL,'',OPEN.dage_geogra_location.fsbgetdescription(MOVIUBG3))  LOCALIDAD,  
        MOVISERV||' - '||Decode(MOVISERV,NULL,'',OPEN.pktblservicio.fsbGetservdesc(MOVISERV)) TIPO_PRODUCTO,  
        MOVICATE COD_CATEGORIA, Decode(MOVICATE,NULL,'',OPEN.dacategori.fsbgetcatedesc(MOVICATE)) DESC_CATEGORIA,  
        (select sucadesc from OPEN.SUBCATEG where sucacate = MOVICATE and sucacodi = MOVISUCA)DESC_SUBCATEGORIA,  
        open.ldci_pkinterfazsap.fvaGetOI(MOVICATE,CONCCLCO) ORD_INTERNA,   
        open.ldci_pkinterfazsap.fvaGetCebeNew(MOVIUBG3,MOVICATE) CEBE,  
        MOVICACA COD_CAUSAL,  
        Decode(MOVICACA,NULL,'''',OPEN.dacauscarg.fsbgetcacadesc(MOVICACA)) CAUSA,  
        MOVITIDO,  
        MOVITIMO||'' - ''||(SELECT TIMODESC FROM open.ic_tipomovi WHERE TIMOCODI = MOVITIMO and rownum=1) MOVITIMO,  
        MOVISIGN SIGNO,  
        Round(Sum(Decode(MOVISIGN,'D',MOVIVALO,'C',-MOVIVALO)),2) VALOR  
        FROM OPEN.IC_MOVIMIEN,OPEN.CONCEPTO  
        WHERE (movitido, movinudo, movifeco) in  
            (  
               SELECT dogetido, dogenudo, dogefemo FROM OPEN.ic_docugene  
                WHERE dogetido IN (71,73)  
                  AND dogefemo BETWEEN '01-03-2015' and '15-03-2015'  
             )  
        AND MOVICONC = CONCCODI  
GROUP BY  movifeco,MOVITIHE,MOVISERV,MOVICICL,MOVICATE,MOVISUCA,MOVIUBG3,MOVISIGN,MOVICACA,MOVITIDO,MOVITIMO,MOVICONC, CONCCLCO
