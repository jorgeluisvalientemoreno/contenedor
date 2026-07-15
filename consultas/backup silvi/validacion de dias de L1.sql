select distinct movifeco, movitido from open.ic_movimien
where movifeco >= '01-07-2025' and movifeco <= '31-07-2025' and movitido in (71,73)
