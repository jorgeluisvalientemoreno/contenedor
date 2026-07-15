select * from LDC_PECOFACT where pcfapefa = 114060
where pcfafere >='01/01/2024';

select * from perifact where pefacodi = 107378

update LDC_PECOFACT set pcfaFEPR = null where pcfapefa = 114060


begin
  -- Call the procedure
  ldc_pkggcma.prprocopyfact;
end;
