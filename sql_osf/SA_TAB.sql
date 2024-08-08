select *
  from open.sa_tab s
 where s.tab_name = 'CCCAS'
    or s.process_name = 'CCCAS'
    or s.aplica_executable = 'CCCAS'
