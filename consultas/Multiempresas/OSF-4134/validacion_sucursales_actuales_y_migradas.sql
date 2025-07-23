select subabanc, subacodi
from  sucubanc
minus
select banco, sucursal
from sucursal_bancaria;