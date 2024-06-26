SELECT to_number(regexp_substr(&sbEstaCort,
                                                   '[^,]+',
                                                   1,
                                                   LEVEL)) AS estacort
                      FROM dual
                    CONNECT BY regexp_substr(&sbEstaCort, '[^,]+', 1, LEVEL) IS NOT NULL 
