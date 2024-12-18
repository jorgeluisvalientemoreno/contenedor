column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

  cursor cuOrdenesNuevaCausal is
    select oo.order_id          Orden,
           ordenes.causal_nueva,
           oo.causal_id         causal_legalizada
      from open.or_order oo,
           (select 327179002 orden, 9777 causal_nueva
              from dual
            union all
            select 326668806 orden, 9777 causal_nueva
              from dual
            union all
            select 327402749 orden, 9777 causal_nueva
              from dual
            union all
            select 327401382 orden, 9777 causal_nueva
              from dual
            union all
            select 327403741 orden, 9777 causal_nueva
              from dual
            union all
            select 326447903 orden, 9777 causal_nueva
              from dual
            union all
            select 327411074 orden, 3443 causal_nueva
              from dual
            union all
            select 327401441 orden, 9777 causal_nueva
              from dual
            union all
            select 327403713 orden, 9777 causal_nueva
              from dual
            union all
            select 326954837 orden, 9777 causal_nueva
              from dual
            union all
            select 326848259 orden, 9777 causal_nueva
              from dual
            union all
            select 327403163 orden, 9777 causal_nueva
              from dual
            union all
            select 327111257 orden, 3443 causal_nueva
              from dual
            union all
            select 327085355 orden, 9777 causal_nueva
              from dual
            union all
            select 327405696 orden, 3443 causal_nueva
              from dual
            union all
            select 327403704 orden, 9777 causal_nueva
              from dual
            union all
            select 327402610 orden, 9777 causal_nueva
              from dual
            union all
            select 327172020 orden, 3443 causal_nueva
              from dual
            union all
            select 327404289 orden, 9777 causal_nueva
              from dual
            union all
            select 327403113 orden, 9777 causal_nueva
              from dual
            union all
            select 327402722 orden, 9777 causal_nueva
              from dual
            union all
            select 327404355 orden, 9777 causal_nueva
              from dual
            union all
            select 327171398 orden, 9777 causal_nueva
              from dual
            union all
            select 327405926 orden, 9777 causal_nueva
              from dual
            union all
            select 327085282 orden, 9777 causal_nueva
              from dual
            union all
            select 327204350 orden, 9777 causal_nueva
              from dual
            union all
            select 326458748 orden, 3443 causal_nueva
              from dual
            union all
            select 326844666 orden, 9777 causal_nueva
              from dual
            union all
            select 327194207 orden, 9777 causal_nueva
              from dual
            union all
            select 327403820 orden, 3443 causal_nueva
              from dual
            union all
            select 327286125 orden, 9777 causal_nueva
              from dual
            union all
            select 327085408 orden, 9777 causal_nueva
              from dual
            union all
            select 327411255 orden, 9777 causal_nueva
              from dual
            union all
            select 327405495 orden, 9777 causal_nueva
              from dual
            union all
            select 327403696 orden, 9777 causal_nueva
              from dual
            union all
            select 326668190 orden, 9777 causal_nueva
              from dual
            union all
            select 327202373 orden, 3443 causal_nueva
              from dual
            union all
            select 327401930 orden, 3443 causal_nueva
              from dual
            union all
            select 327411780 orden, 9777 causal_nueva
              from dual
            union all
            select 327403189 orden, 9777 causal_nueva
              from dual
            union all
            select 324532030 orden, 3443 causal_nueva
              from dual
            union all
            select 327085368 orden, 9777 causal_nueva
              from dual
            union all
            select 327175619 orden, 3443 causal_nueva
              from dual
            union all
            select 327403177 orden, 9777 causal_nueva
              from dual
            union all
            select 327404953 orden, 9777 causal_nueva
              from dual
            union all
            select 327402965 orden, 9777 causal_nueva
              from dual
            union all
            select 327402535 orden, 9777 causal_nueva
              from dual
            union all
            select 327402701 orden, 9777 causal_nueva
              from dual
            union all
            select 327086195 orden, 9777 causal_nueva
              from dual
            union all
            select 327403740 orden, 9777 causal_nueva
              from dual
            union all
            select 327411876 orden, 3443 causal_nueva
              from dual
            union all
            select 327402246 orden, 9777 causal_nueva
              from dual
            union all
            select 327179693 orden, 3443 causal_nueva
              from dual
            union all
            select 327401584 orden, 9777 causal_nueva
              from dual
            union all
            select 327405669 orden, 9777 causal_nueva
              from dual
            union all
            select 326843710 orden, 3443 causal_nueva
              from dual
            union all
            select 327404034 orden, 9777 causal_nueva
              from dual
            union all
            select 327405694 orden, 9777 causal_nueva
              from dual
            union all
            select 327401639 orden, 9777 causal_nueva
              from dual
            union all
            select 327411196 orden, 9777 causal_nueva
              from dual
            union all
            select 327405912 orden, 9777 causal_nueva
              from dual
            union all
            select 327410940 orden, 3443 causal_nueva
              from dual
            union all
            select 327175694 orden, 9777 causal_nueva
              from dual
            union all
            select 327405909 orden, 9777 causal_nueva
              from dual
            union all
            select 327403636 orden, 9777 causal_nueva
              from dual
            union all
            select 327085384 orden, 9777 causal_nueva
              from dual
            union all
            select 327556346 orden, 3443 causal_nueva
              from dual
            union all
            select 327402976 orden, 9777 causal_nueva
              from dual
            union all
            select 327187336 orden, 3443 causal_nueva
              from dual
            union all
            select 326867097 orden, 3443 causal_nueva
              from dual
            union all
            select 327402978 orden, 9777 causal_nueva
              from dual
            union all
            select 327085490 orden, 9777 causal_nueva
              from dual
            union all
            select 327188383 orden, 3443 causal_nueva
              from dual
            union all
            select 327406020 orden, 9777 causal_nueva
              from dual
            union all
            select 327093573 orden, 3443 causal_nueva
              from dual
            union all
            select 326850203 orden, 3443 causal_nueva
              from dual
            union all
            select 324612318 orden, 3443 causal_nueva
              from dual
            union all
            select 327402653 orden, 3443 causal_nueva
              from dual
            union all
            select 327402332 orden, 9777 causal_nueva
              from dual
            union all
            select 327252502 orden, 3443 causal_nueva
              from dual
            union all
            select 327179443 orden, 3443 causal_nueva
              from dual
            union all
            select 327412002 orden, 3443 causal_nueva
              from dual
            union all
            select 327405524 orden, 9777 causal_nueva
              from dual
            union all
            select 327176688 orden, 9777 causal_nueva
              from dual
            union all
            select 327405288 orden, 9777 causal_nueva
              from dual
            union all
            select 327410015 orden, 3443 causal_nueva
              from dual
            union all
            select 327411600 orden, 3443 causal_nueva
              from dual
            union all
            select 327181262 orden, 3443 causal_nueva
              from dual
            union all
            select 327404627 orden, 9777 causal_nueva
              from dual
            union all
            select 327405065 orden, 3443 causal_nueva
              from dual
            union all
            select 327179798 orden, 3443 causal_nueva
              from dual
            union all
            select 327120752 orden, 3443 causal_nueva
              from dual
            union all
            select 327403222 orden, 9777 causal_nueva
              from dual
            union all
            select 327405908 orden, 9777 causal_nueva
              from dual
            union all
            select 326847277 orden, 3443 causal_nueva
              from dual
            union all
            select 326688182 orden, 9777 causal_nueva
              from dual
            union all
            select 327119956 orden, 3443 causal_nueva
              from dual
            union all
            select 327121248 orden, 9777 causal_nueva
              from dual
            union all
            select 327401484 orden, 3443 causal_nueva
              from dual
            union all
            select 327410737 orden, 9777 causal_nueva
              from dual
            union all
            select 327411417 orden, 3443 causal_nueva
              from dual
            union all
            select 327401655 orden, 3443 causal_nueva
              from dual
            union all
            select 327404132 orden, 3443 causal_nueva
              from dual
            union all
            select 327403635 orden, 3443 causal_nueva
              from dual
            union all
            select 327408018 orden, 3443 causal_nueva
              from dual
            union all
            select 327179480 orden, 9777 causal_nueva
              from dual
            union all
            select 327411247 orden, 9777 causal_nueva
              from dual
            union all
            select 327402591 orden, 9777 causal_nueva
              from dual
            union all
            select 327172825 orden, 3443 causal_nueva
              from dual
            union all
            select 327401876 orden, 3443 causal_nueva
              from dual
            union all
            select 327556417 orden, 3443 causal_nueva
              from dual
            union all
            select 327405791 orden, 3443 causal_nueva
              from dual
            union all
            select 327175677 orden, 9777 causal_nueva
              from dual
            union all
            select 327411904 orden, 9777 causal_nueva
              from dual
            union all
            select 327403760 orden, 9777 causal_nueva
              from dual
            union all
            select 327202764 orden, 9777 causal_nueva
              from dual
            union all
            select 327402592 orden, 3443 causal_nueva
              from dual
            union all
            select 327285882 orden, 3443 causal_nueva
              from dual
            union all
            select 327402759 orden, 3443 causal_nueva
              from dual
            union all
            select 326864643 orden, 3443 causal_nueva
              from dual
            union all
            select 327404608 orden, 3443 causal_nueva
              from dual
            union all
            select 327175709 orden, 9777 causal_nueva
              from dual
            union all
            select 327195727 orden, 3443 causal_nueva
              from dual
            union all
            select 327404925 orden, 9777 causal_nueva
              from dual
            union all
            select 327402231 orden, 3443 causal_nueva
              from dual
            union all
            select 327178804 orden, 3443 causal_nueva
              from dual
            union all
            select 327119698 orden, 3443 causal_nueva
              from dual
            union all
            select 327104364 orden, 3443 causal_nueva
              from dual
            union all
            select 327402739 orden, 3443 causal_nueva
              from dual
            union all
            select 326445504 orden, 3443 causal_nueva
              from dual
            union all
            select 327405091 orden, 9777 causal_nueva
              from dual
            union all
            select 327401675 orden, 3443 causal_nueva
              from dual
            union all
            select 327405095 orden, 3443 causal_nueva
              from dual
            union all
            select 327402747 orden, 3443 causal_nueva
              from dual
            union all
            select 327401452 orden, 3443 causal_nueva
              from dual
            union all
            select 327405734 orden, 3443 causal_nueva
              from dual
            union all
            select 327294684 orden, 3443 causal_nueva
              from dual
            union all
            select 327120751 orden, 3443 causal_nueva
              from dual
            union all
            select 324528132 orden, 3443 causal_nueva
              from dual
            union all
            select 327405754 orden, 9777 causal_nueva
              from dual
            union all
            select 327556333 orden, 3443 causal_nueva
              from dual
            union all
            select 326446036 orden, 3443 causal_nueva
              from dual
            union all
            select 327206326 orden, 3443 causal_nueva
              from dual
            union all
            select 327410471 orden, 9777 causal_nueva
              from dual
            union all
            select 326350823 orden, 3443 causal_nueva
              from dual
            union all
            select 327405704 orden, 3443 causal_nueva
              from dual
            union all
            select 327405756 orden, 3443 causal_nueva
              from dual
            union all
            select 327405126 orden, 3443 causal_nueva
              from dual
            union all
            select 327178111 orden, 3443 causal_nueva
              from dual
            union all
            select 327099784 orden, 3443 causal_nueva
              from dual
            union all
            select 326445503 orden, 3443 causal_nueva
              from dual
            union all
            select 327401354 orden, 3443 causal_nueva
              from dual
            union all
            select 327410574 orden, 3443 causal_nueva
              from dual
            union all
            select 326445517 orden, 3443 causal_nueva
              from dual
            union all
            select 327411910 orden, 9777 causal_nueva
              from dual
            union all
            select 327405389 orden, 9777 causal_nueva
              from dual
            union all
            select 327402686 orden, 3443 causal_nueva
              from dual
            union all
            select 324531355 orden, 3443 causal_nueva
              from dual
            union all
            select 327411445 orden, 3443 causal_nueva
              from dual
            union all
            select 327402149 orden, 3443 causal_nueva
              from dual
            union all
            select 327404876 orden, 3443 causal_nueva
              from dual
            union all
            select 327405735 orden, 9777 causal_nueva
              from dual
            union all
            select 326446561 orden, 3443 causal_nueva
              from dual
            union all
            select 326686950 orden, 9777 causal_nueva
              from dual
            union all
            select 327411677 orden, 3443 causal_nueva
              from dual
            union all
            select 327401855 orden, 3443 causal_nueva
              from dual
            union all
            select 327402624 orden, 3443 causal_nueva
              from dual
            union all
            select 327403736 orden, 3443 causal_nueva
              from dual
            union all
            select 327411446 orden, 3443 causal_nueva
              from dual
            union all
            select 326455293 orden, 3443 causal_nueva
              from dual
            union all
            select 327401640 orden, 3443 causal_nueva
              from dual
            union all
            select 327402658 orden, 3443 causal_nueva
              from dual
            union all
            select 327404341 orden, 3443 causal_nueva
              from dual
            union all
            select 327411474 orden, 3443 causal_nueva
              from dual
            union all
            select 326458804 orden, 3443 causal_nueva
              from dual
            union all
            select 327402310 orden, 3443 causal_nueva
              from dual
            union all
            select 327406023 orden, 3443 causal_nueva
              from dual
            union all
            select 326859388 orden, 3443 causal_nueva
              from dual
            union all
            select 326100939 orden, 3443 causal_nueva
              from dual
            union all
            select 327403765 orden, 3443 causal_nueva
              from dual
            union all
            select 327404964 orden, 3443 causal_nueva
              from dual
            union all
            select 327402854 orden, 3443 causal_nueva
              from dual
            union all
            select 327404828 orden, 3443 causal_nueva
              from dual
            union all
            select 327404980 orden, 3443 causal_nueva
              from dual
            union all
            select 327402596 orden, 3443 causal_nueva
              from dual
            union all
            select 326679491 orden, 3443 causal_nueva
              from dual
            union all
            select 326859067 orden, 3443 causal_nueva
              from dual
            union all
            select 327119822 orden, 3443 causal_nueva
              from dual
            union all
            select 327404816 orden, 3443 causal_nueva
              from dual
            union all
            select 327402154 orden, 3443 causal_nueva
              from dual
            union all
            select 327402526 orden, 3443 causal_nueva
              from dual
            union all
            select 327095921 orden, 3443 causal_nueva
              from dual
            union all
            select 327405671 orden, 3443 causal_nueva
              from dual
            union all
            select 326855627 orden, 3443 causal_nueva
              from dual
            union all
            select 327556413 orden, 3443 causal_nueva
              from dual
            union all
            select 327404459 orden, 3443 causal_nueva
              from dual
            union all
            select 324612295 orden, 3443 causal_nueva
              from dual
            union all
            select 327404972 orden, 3443 causal_nueva
              from dual
            union all
            select 326868531 orden, 3443 causal_nueva
              from dual
            union all
            select 327404846 orden, 3443 causal_nueva
              from dual
            union all
            select 326460895 orden, 3443 causal_nueva
              from dual
            union all
            select 327405624 orden, 3443 causal_nueva
              from dual
            union all
            select 326867782 orden, 3443 causal_nueva
              from dual
            union all
            select 327402867 orden, 3443 causal_nueva
              from dual
            union all
            select 327405945 orden, 9777 causal_nueva
              from dual
            union all
            select 327402523 orden, 3443 causal_nueva
              from dual
            union all
            select 327411851 orden, 3443 causal_nueva
              from dual
            union all
            select 327403618 orden, 3443 causal_nueva
              from dual
            union all
            select 327401496 orden, 3443 causal_nueva
              from dual
            union all
            select 327404560 orden, 3443 causal_nueva
              from dual
            union all
            select 327402257 orden, 3443 causal_nueva
              from dual
            union all
            select 326695725 orden, 9777 causal_nueva
              from dual
            union all
            select 326865355 orden, 3443 causal_nueva
              from dual
            union all
            select 326848197 orden, 3443 causal_nueva
              from dual
            union all
            select 327406072 orden, 3443 causal_nueva
              from dual
            union all
            select 326860267 orden, 3443 causal_nueva
              from dual
            union all
            select 327405816 orden, 3443 causal_nueva
              from dual
            union all
            select 327410741 orden, 3443 causal_nueva
              from dual
            union all
            select 326100516 orden, 3443 causal_nueva
              from dual
            union all
            select 327405890 orden, 3443 causal_nueva
              from dual
            union all
            select 327403747 orden, 3443 causal_nueva
              from dual
            union all
            select 327402279 orden, 3443 causal_nueva
              from dual
            union all
            select 327305442 orden, 3443 causal_nueva
              from dual
            union all
            select 327172941 orden, 3443 causal_nueva
              from dual
            union all
            select 327404595 orden, 3443 causal_nueva
              from dual
            union all
            select 327405011 orden, 3443 causal_nueva
              from dual
            union all
            select 327405086 orden, 3443 causal_nueva
              from dual
            union all
            select 326860106 orden, 3443 causal_nueva
              from dual
            union all
            select 327402085 orden, 3443 causal_nueva
              from dual
            union all
            select 326856825 orden, 3443 causal_nueva
              from dual
            union all
            select 327402161 orden, 3443 causal_nueva
              from dual
            union all
            select 327085230 orden, 3443 causal_nueva
              from dual
            union all
            select 327556247 orden, 3443 causal_nueva
              from dual
            union all
            select 327198493 orden, 3443 causal_nueva
              from dual
            union all
            select 327408986 orden, 3443 causal_nueva
              from dual
            union all
            select 327403140 orden, 3443 causal_nueva
              from dual
            union all
            select 327170076 orden, 3443 causal_nueva
              from dual
            union all
            select 327170158 orden, 3443 causal_nueva
              from dual
            union all
            select 327401401 orden, 3443 causal_nueva
              from dual
            union all
            select 327404948 orden, 3443 causal_nueva
              from dual
            union all
            select 327119785 orden, 3443 causal_nueva
              from dual
            union all
            select 327405803 orden, 3443 causal_nueva
              from dual
            union all
            select 327114656 orden, 3443 causal_nueva
              from dual
            union all
            select 326863026 orden, 3443 causal_nueva
              from dual
            union all
            select 326446673 orden, 3443 causal_nueva
              from dual
            union all
            select 326962889 orden, 3443 causal_nueva
              from dual
            union all
            select 327402668 orden, 3443 causal_nueva
              from dual
            union all
            select 326668098 orden, 3443 causal_nueva
              from dual
            union all
            select 327401759 orden, 3443 causal_nueva
              from dual
            union all
            select 327199910 orden, 3443 causal_nueva
              from dual
            union all
            select 326854219 orden, 3443 causal_nueva
              from dual
            union all
            select 326668952 orden, 3443 causal_nueva
              from dual
            union all
            select 327178906 orden, 3443 causal_nueva
              from dual
            union all
            select 326868450 orden, 3443 causal_nueva
              from dual
            union all
            select 327175724 orden, 3443 causal_nueva
              from dual
            union all
            select 326969603 orden, 3443 causal_nueva
              from dual
            union all
            select 327405182 orden, 3443 causal_nueva
              from dual
            union all
            select 327179683 orden, 3443 causal_nueva
              from dual
            union all
            select 327169418 orden, 3443 causal_nueva
              from dual
            union all
            select 327402580 orden, 3443 causal_nueva
              from dual
            union all
            select 326446995 orden, 3443 causal_nueva
              from dual
            union all
            select 327402792 orden, 3443 causal_nueva
              from dual
            union all
            select 326462404 orden, 3443 causal_nueva
              from dual
            union all
            select 324528696 orden, 3443 causal_nueva
              from dual
            union all
            select 327178101 orden, 3443 causal_nueva
              from dual
            union all
            select 327403889 orden, 3443 causal_nueva
              from dual
            union all
            select 327402673 orden, 3443 causal_nueva
              from dual
            union all
            select 327402127 orden, 3443 causal_nueva
              from dual
            union all
            select 327402982 orden, 3443 causal_nueva
              from dual
            union all
            select 327402516 orden, 3443 causal_nueva
              from dual
            union all
            select 327405570 orden, 3443 causal_nueva
              from dual
            union all
            select 326100520 orden, 3443 causal_nueva
              from dual
            union all
            select 327180371 orden, 3443 causal_nueva
              from dual
            union all
            select 326445490 orden, 3443 causal_nueva
              from dual
            union all
            select 327405455 orden, 3443 causal_nueva
              from dual
            union all
            select 327402118 orden, 3443 causal_nueva
              from dual
            union all
            select 327401444 orden, 3443 causal_nueva
              from dual
            union all
            select 327401393 orden, 3443 causal_nueva
              from dual
            union all
            select 327401713 orden, 3443 causal_nueva
              from dual
            union all
            select 327204293 orden, 3443 causal_nueva
              from dual
            union all
            select 327405644 orden, 3443 causal_nueva
              from dual
            union all
            select 327404870 orden, 3443 causal_nueva
              from dual
            union all
            select 327206394 orden, 3443 causal_nueva
              from dual
            union all
            select 327403012 orden, 3443 causal_nueva
              from dual
            union all
            select 327404340 orden, 3443 causal_nueva
              from dual
            union all
            select 327406419 orden, 3443 causal_nueva
              from dual
            union all
            select 326848467 orden, 3443 causal_nueva
              from dual
            union all
            select 327403823 orden, 3443 causal_nueva
              from dual
            union all
            select 326863198 orden, 3443 causal_nueva
              from dual
            union all
            select 326459249 orden, 3443 causal_nueva
              from dual
            union all
            select 327411875 orden, 3443 causal_nueva
              from dual
            union all
            select 327404107 orden, 3443 causal_nueva
              from dual
            union all
            select 327403930 orden, 3443 causal_nueva
              from dual
            union all
            select 327305441 orden, 3443 causal_nueva
              from dual
            union all
            select 327556332 orden, 3443 causal_nueva
              from dual
            union all
            select 327403286 orden, 3443 causal_nueva
              from dual
            union all
            select 326847940 orden, 3443 causal_nueva
              from dual
            union all
            select 327401577 orden, 3443 causal_nueva
              from dual
            union all
            select 327404987 orden, 3443 causal_nueva
              from dual
            union all
            select 327180847 orden, 3443 causal_nueva
              from dual
            union all
            select 327401319 orden, 3443 causal_nueva
              from dual
            union all
            select 326978817 orden, 3443 causal_nueva
              from dual
            union all
            select 327405743 orden, 3443 causal_nueva
              from dual
            union all
            select 326668209 orden, 3443 causal_nueva
              from dual
            union all
            select 326856922 orden, 3443 causal_nueva
              from dual
            union all
            select 327402250 orden, 3443 causal_nueva
              from dual
            union all
            select 326869592 orden, 3443 causal_nueva
              from dual
            union all
            select 327185717 orden, 3443 causal_nueva
              from dual
            union all
            select 327170762 orden, 3443 causal_nueva
              from dual
            union all
            select 327405764 orden, 3443 causal_nueva
              from dual
            union all
            select 327403111 orden, 3443 causal_nueva
              from dual
            union all
            select 326114360 orden, 3443 causal_nueva
              from dual
            union all
            select 326979306 orden, 3443 causal_nueva
              from dual
            union all
            select 327402384 orden, 3443 causal_nueva
              from dual
            union all
            select 327173162 orden, 3443 causal_nueva
              from dual
            union all
            select 327404890 orden, 3443 causal_nueva
              from dual
            union all
            select 327173179 orden, 3443 causal_nueva
              from dual
            union all
            select 327404717 orden, 3443 causal_nueva
              from dual
            union all
            select 327402560 orden, 3443 causal_nueva
              from dual
            union all
            select 327411790 orden, 3443 causal_nueva
              from dual
            union all
            select 326101079 orden, 3443 causal_nueva
              from dual
            union all
            select 327411920 orden, 3443 causal_nueva
              from dual
            union all
            select 327405610 orden, 3443 causal_nueva
              from dual
            union all
            select 326859238 orden, 3443 causal_nueva
              from dual
            union all
            select 326862405 orden, 3443 causal_nueva
              from dual
            union all
            select 326867572 orden, 3443 causal_nueva
              from dual
            union all
            select 327411055 orden, 3443 causal_nueva
              from dual
            union all
            select 326445432 orden, 3443 causal_nueva
              from dual
            union all
            select 327121324 orden, 3443 causal_nueva
              from dual
            union all
            select 327402604 orden, 3443 causal_nueva
              from dual
            union all
            select 327187766 orden, 3443 causal_nueva
              from dual
            union all
            select 326113850 orden, 3443 causal_nueva
              from dual
            union all
            select 327411626 orden, 3443 causal_nueva
              from dual
            union all
            select 327404868 orden, 3443 causal_nueva
              from dual
            union all
            select 327403278 orden, 3443 causal_nueva
              from dual
            union all
            select 327172833 orden, 3443 causal_nueva
              from dual
            union all
            select 327404380 orden, 3443 causal_nueva
              from dual
            union all
            select 327172484 orden, 3443 causal_nueva
              from dual
            union all
            select 327401977 orden, 3443 causal_nueva
              from dual
            union all
            select 327410855 orden, 9777 causal_nueva
              from dual
            union all
            select 326962870 orden, 3443 causal_nueva
              from dual
            union all
            select 327404712 orden, 9777 causal_nueva
              from dual
            union all
            select 327174519 orden, 9777 causal_nueva
              from dual
            union all
            select 327411469 orden, 9777 causal_nueva
              from dual
            union all
            select 327402502 orden, 3443 causal_nueva
              from dual
            union all
            select 327119908 orden, 9777 causal_nueva
              from dual
            union all
            select 327556348 orden, 3443 causal_nueva
              from dual
            union all
            select 327121205 orden, 3443 causal_nueva
              from dual
            union all
            select 327178104 orden, 3443 causal_nueva
              from dual
            union all
            select 327173784 orden, 9777 causal_nueva
              from dual
            union all
            select 327401375 orden, 9777 causal_nueva
              from dual
            union all
            select 327085313 orden, 9777 causal_nueva
              from dual
            union all
            select 327402487 orden, 3443 causal_nueva
              from dual
            union all
            select 327405292 orden, 3443 causal_nueva
              from dual
            union all
            select 327403755 orden, 3443 causal_nueva
              from dual
            union all
            select 327402322 orden, 3443 causal_nueva
              from dual
            union all
            select 327199010 orden, 3443 causal_nueva
              from dual
            union all
            select 327403126 orden, 3443 causal_nueva
              from dual
            union all
            select 327405005 orden, 9777 causal_nueva
              from dual
            union all
            select 327405013 orden, 3443 causal_nueva
              from dual
            union all
            select 327402046 orden, 9777 causal_nueva
              from dual
            union all
            select 326462561 orden, 3443 causal_nueva
              from dual
            union all
            select 327178020 orden, 3443 causal_nueva
              from dual
            union all
            select 326461399 orden, 3443 causal_nueva
              from dual
            union all
            select 326859100 orden, 9777 causal_nueva
              from dual
            union all
            select 326668966 orden, 3443 causal_nueva
              from dual
            union all
            select 327411606 orden, 3443 causal_nueva
              from dual
            union all
            select 326962855 orden, 3443 causal_nueva
              from dual
            union all
            select 327404374 orden, 9777 causal_nueva
              from dual
            union all
            select 327172824 orden, 3443 causal_nueva
              from dual
            union all
            select 327403720 orden, 9777 causal_nueva
              from dual
            union all
            select 327177782 orden, 9777 causal_nueva
              from dual
            union all
            select 326869382 orden, 3443 causal_nueva
              from dual
            union all
            select 327085425 orden, 9777 causal_nueva
              from dual
            union all
            select 327405460 orden, 3443 causal_nueva
              from dual
            union all
            select 327405581 orden, 3443 causal_nueva
              from dual
            union all
            select 327404673 orden, 9777 causal_nueva
              from dual
            union all
            select 327175670 orden, 3443 causal_nueva
              from dual
            union all
            select 327401447 orden, 9777 causal_nueva
              from dual
            union all
            select 326668010 orden, 3443 causal_nueva
              from dual
            union all
            select 327173283 orden, 9777 causal_nueva
              from dual
            union all
            select 327401407 orden, 3443 causal_nueva
              from dual
            union all
            select 327403609 orden, 9777 causal_nueva
              from dual
            union all
            select 327407588 orden, 3443 causal_nueva
              from dual
            union all
            select 326860447 orden, 3443 causal_nueva
              from dual
            union all
            select 326845241 orden, 9777 causal_nueva
              from dual
            union all
            select 327404427 orden, 9777 causal_nueva
              from dual
            union all
            select 327401749 orden, 9777 causal_nueva
              from dual
            union all
            select 327402944 orden, 9777 causal_nueva
              from dual
            union all
            select 326100935 orden, 3443 causal_nueva
              from dual
            union all
            select 327411889 orden, 3443 causal_nueva
              from dual
            union all
            select 327403145 orden, 3443 causal_nueva
              from dual
            union all
            select 327556257 orden, 3443 causal_nueva
              from dual
            union all
            select 327201516 orden, 9777 causal_nueva
              from dual
            union all
            select 327404191 orden, 3443 causal_nueva
              from dual
            union all
            select 327179618 orden, 3443 causal_nueva
              from dual
            union all
            select 327403866 orden, 3443 causal_nueva
              from dual
            union all
            select 327404264 orden, 3443 causal_nueva
              from dual
            union all
            select 326859389 orden, 3443 causal_nueva
              from dual
            union all
            select 327402547 orden, 3443 causal_nueva
              from dual
            union all
            select 327403165 orden, 3443 causal_nueva
              from dual
            union all
            select 327085964 orden, 9777 causal_nueva
              from dual
            union all
            select 327411240 orden, 3443 causal_nueva
              from dual
            union all
            select 327099787 orden, 3443 causal_nueva
              from dual
            union all
            select 326340348 orden, 3443 causal_nueva
              from dual
            union all
            select 326459498 orden, 3443 causal_nueva
              from dual
            union all
            select 327169236 orden, 3443 causal_nueva
              from dual
            union all
            select 327405934 orden, 3443 causal_nueva
              from dual
            union all
            select 327409318 orden, 3443 causal_nueva
              from dual
            union all
            select 327402609 orden, 3443 causal_nueva
              from dual
            union all
            select 327412012 orden, 3443 causal_nueva
              from dual
            union all
            select 326844446 orden, 3443 causal_nueva
              from dual
            union all
            select 327402654 orden, 3443 causal_nueva
              from dual
            union all
            select 327085250 orden, 3443 causal_nueva
              from dual
            union all
            select 327095419 orden, 3443 causal_nueva
              from dual
            union all
            select 327402337 orden, 3443 causal_nueva
              from dual
            union all
            select 327405589 orden, 3443 causal_nueva
              from dual
            union all
            select 327286174 orden, 3443 causal_nueva
              from dual
            union all
            select 327178758 orden, 3443 causal_nueva
              from dual
            union all
            select 327401344 orden, 3443 causal_nueva
              from dual
            union all
            select 326857782 orden, 3443 causal_nueva
              from dual
            union all
            select 327172836 orden, 3443 causal_nueva
              from dual
            union all
            select 327409304 orden, 3443 causal_nueva
              from dual
            union all
            select 326668223 orden, 3443 causal_nueva
              from dual
            union all
            select 327405526 orden, 3443 causal_nueva
              from dual
            union all
            select 327409224 orden, 9777 causal_nueva
              from dual
            union all
            select 326867236 orden, 3443 causal_nueva
              from dual
            union all
            select 327174561 orden, 3443 causal_nueva
              from dual
            union all
            select 327203349 orden, 9777 causal_nueva
              from dual
            union all
            select 327175602 orden, 9777 causal_nueva
              from dual
            union all
            select 327180788 orden, 9777 causal_nueva
              from dual
            union all
            select 327405117 orden, 3443 causal_nueva
              from dual
            union all
            select 326668106 orden, 3443 causal_nueva
              from dual
            union all
            select 327556285 orden, 3443 causal_nueva
              from dual
            union all
            select 327404675 orden, 9777 causal_nueva
              from dual
            union all
            select 327170488 orden, 3443 causal_nueva
              from dual
            union all
            select 327405047 orden, 9777 causal_nueva
              from dual
            union all
            select 327404414 orden, 9777 causal_nueva
              from dual
            union all
            select 327402466 orden, 3443 causal_nueva
              from dual
            union all
            select 326843612 orden, 3443 causal_nueva
              from dual
            union all
            select 327409021 orden, 3443 causal_nueva
              from dual
            union all
            select 327556485 orden, 3443 causal_nueva
              from dual
            union all
            select 327404281 orden, 3443 causal_nueva
              from dual
            union all
            select 327189633 orden, 3443 causal_nueva
              from dual
            union all
            select 326857244 orden, 3443 causal_nueva
              from dual
            union all
            select 327405539 orden, 3443 causal_nueva
              from dual
            union all
            select 326681603 orden, 3443 causal_nueva
              from dual
            union all
            select 327402788 orden, 3443 causal_nueva
              from dual
            union all
            select 327401762 orden, 3443 causal_nueva
              from dual
            union all
            select 327403217 orden, 3443 causal_nueva
              from dual
            union all
            select 327556337 orden, 3443 causal_nueva
              from dual
            union all
            select 327405944 orden, 3443 causal_nueva
              from dual
            union all
            select 327208870 orden, 3443 causal_nueva
              from dual
            union all
            select 326556571 orden, 3443 causal_nueva
              from dual
            union all
            select 327405284 orden, 3443 causal_nueva
              from dual
            union all
            select 327405372 orden, 3443 causal_nueva
              from dual
            union all
            select 327401965 orden, 3443 causal_nueva
              from dual
            union all
            select 327405497 orden, 3443 causal_nueva
              from dual
            union all
            select 327405172 orden, 3443 causal_nueva
              from dual
            union all
            select 326448011 orden, 3443 causal_nueva
              from dual
            union all
            select 327410921 orden, 3443 causal_nueva
              from dual
            union all
            select 327412031 orden, 3443 causal_nueva
              from dual
            union all
            select 326854193 orden, 3443 causal_nueva
              from dual
            union all
            select 327404798 orden, 3443 causal_nueva
              from dual
            union all
            select 327402937 orden, 3443 causal_nueva
              from dual
            union all
            select 327405768 orden, 3443 causal_nueva
              from dual
            union all
            select 327404375 orden, 3443 causal_nueva
              from dual
            union all
            select 327410393 orden, 3443 causal_nueva
              from dual
            union all
            select 327402462 orden, 3443 causal_nueva
              from dual
            union all
            select 327402281 orden, 3443 causal_nueva
              from dual
            union all
            select 327401386 orden, 3443 causal_nueva
              from dual
            union all
            select 327401994 orden, 3443 causal_nueva
              from dual
            union all
            select 327405040 orden, 9777 causal_nueva
              from dual
            union all
            select 327404632 orden, 3443 causal_nueva
              from dual
            union all
            select 326855628 orden, 3443 causal_nueva
              from dual
            union all
            select 327401745 orden, 3443 causal_nueva
              from dual
            union all
            select 327411370 orden, 3443 causal_nueva
              from dual
            union all
            select 327556452 orden, 3443 causal_nueva
              from dual
            union all
            select 327402643 orden, 3443 causal_nueva
              from dual
            union all
            select 327402585 orden, 3443 causal_nueva
              from dual
            union all
            select 327405421 orden, 9777 causal_nueva
              from dual
            union all
            select 327179469 orden, 9777 causal_nueva
              from dual
            union all
            select 327402720 orden, 3443 causal_nueva
              from dual
            union all
            select 327405558 orden, 3443 causal_nueva
              from dual
            union all
            select 326113786 orden, 3443 causal_nueva
              from dual
            union all
            select 326455296 orden, 3443 causal_nueva
              from dual
            union all
            select 327407232 orden, 3443 causal_nueva
              from dual
            union all
            select 326962878 orden, 3443 causal_nueva
              from dual
            union all
            select 327410027 orden, 3443 causal_nueva
              from dual
            union all
            select 327404634 orden, 3443 causal_nueva
              from dual
            union all
            select 326447604 orden, 3443 causal_nueva
              from dual
            union all
            select 327401542 orden, 3443 causal_nueva
              from dual
            union all
            select 327403936 orden, 3443 causal_nueva
              from dual
            union all
            select 327193778 orden, 3443 causal_nueva
              from dual
            union all
            select 327404066 orden, 3443 causal_nueva
              from dual
            union all
            select 327409657 orden, 3443 causal_nueva
              from dual
            union all
            select 327402666 orden, 3443 causal_nueva
              from dual
            union all
            select 327404615 orden, 3443 causal_nueva
              from dual
            union all
            select 327405357 orden, 3443 causal_nueva
              from dual
            union all
            select 327410998 orden, 3443 causal_nueva
              from dual
            union all
            select 326552286 orden, 3443 causal_nueva
              from dual
            union all
            select 327402595 orden, 3443 causal_nueva
              from dual
            union all
            select 327175625 orden, 3443 causal_nueva
              from dual
            union all
            select 326843594 orden, 3443 causal_nueva
              from dual
            union all
            select 327404612 orden, 3443 causal_nueva
              from dual
            union all
            select 327556246 orden, 3443 causal_nueva
              from dual
            union all
            select 326856818 orden, 3443 causal_nueva
              from dual
            union all
            select 326552085 orden, 3443 causal_nueva
              from dual
            union all
            select 327405271 orden, 3443 causal_nueva
              from dual
            union all
            select 326845202 orden, 3443 causal_nueva
              from dual
            union all
            select 327404532 orden, 3443 causal_nueva
              from dual
            union all
            select 327401658 orden, 3443 causal_nueva
              from dual
            union all
            select 327401500 orden, 3443 causal_nueva
              from dual
            union all
            select 326860076 orden, 3443 causal_nueva
              from dual
            union all
            select 327405191 orden, 9777 causal_nueva
              from dual
            union all
            select 327119682 orden, 3443 causal_nueva
              from dual
            union all
            select 326668021 orden, 3443 causal_nueva
              from dual
            union all
            select 327411969 orden, 3443 causal_nueva
              from dual
            union all
            select 326668063 orden, 3443 causal_nueva
              from dual
            union all
            select 327408175 orden, 3443 causal_nueva
              from dual
            union all
            select 327412024 orden, 3443 causal_nueva
              from dual
            union all
            select 326980817 orden, 9777 causal_nueva
              from dual
            union all
            select 327206398 orden, 3443 causal_nueva
              from dual
            union all
            select 326962903 orden, 3443 causal_nueva
              from dual
            union all
            select 326864094 orden, 3443 causal_nueva
              from dual
            union all
            select 327556406 orden, 3443 causal_nueva
              from dual
            union all
            select 327174662 orden, 3443 causal_nueva
              from dual
            union all
            select 327402080 orden, 3443 causal_nueva
              from dual
            union all
            select 326940864 orden, 3443 causal_nueva
              from dual
            union all
            select 327405188 orden, 3443 causal_nueva
              from dual
            union all
            select 327405741 orden, 3443 causal_nueva
              from dual
            union all
            select 327404206 orden, 3443 causal_nueva
              from dual
            union all
            select 327404168 orden, 3443 causal_nueva
              from dual
            union all
            select 327405068 orden, 3443 causal_nueva
              from dual
            union all
            select 326844841 orden, 3443 causal_nueva
              from dual
            union all
            select 326850114 orden, 3443 causal_nueva
              from dual
            union all
            select 327402173 orden, 3443 causal_nueva
              from dual
            union all
            select 327085957 orden, 3443 causal_nueva
              from dual
            union all
            select 327411293 orden, 3443 causal_nueva
              from dual
            union all
            select 327401643 orden, 3443 causal_nueva
              from dual
            union all
            select 327402704 orden, 3443 causal_nueva
              from dual
            union all
            select 327404391 orden, 3443 causal_nueva
              from dual
            union all
            select 326856884 orden, 3443 causal_nueva
              from dual
            union all
            select 327401442 orden, 3443 causal_nueva
              from dual
            union all
            select 327556416 orden, 3443 causal_nueva
              from dual
            union all
            select 327120745 orden, 3443 causal_nueva
              from dual
            union all
            select 327403640 orden, 3443 causal_nueva
              from dual
            union all
            select 327404096 orden, 3443 causal_nueva
              from dual
            union all
            select 327402907 orden, 3443 causal_nueva
              from dual
            union all
            select 327403114 orden, 3443 causal_nueva
              from dual
            union all
            select 327403055 orden, 3443 causal_nueva
              from dual
            union all
            select 327402902 orden, 3443 causal_nueva
              from dual
            union all
            select 327402549 orden, 3443 causal_nueva
              from dual
            union all
            select 327401723 orden, 3443 causal_nueva
              from dual
            union all
            select 326862593 orden, 3443 causal_nueva
              from dual
            union all
            select 327410005 orden, 3443 causal_nueva
              from dual
            union all
            select 327401380 orden, 3443 causal_nueva
              from dual
            union all
            select 326962884 orden, 3443 causal_nueva
              from dual
            union all
            select 327411778 orden, 3443 causal_nueva
              from dual
            union all
            select 326864625 orden, 3443 causal_nueva
              from dual
            union all
            select 327403843 orden, 3443 causal_nueva
              from dual
            union all
            select 327119906 orden, 3443 causal_nueva
              from dual
            union all
            select 327404570 orden, 3443 causal_nueva
              from dual
            union all
            select 327405398 orden, 3443 causal_nueva
              from dual
            union all
            select 327402040 orden, 3443 causal_nueva
              from dual
            union all
            select 327403687 orden, 3443 causal_nueva
              from dual
            union all
            select 327405286 orden, 3443 causal_nueva
              from dual
            union all
            select 327556267 orden, 3443 causal_nueva
              from dual
            union all
            select 327402538 orden, 3443 causal_nueva
              from dual
            union all
            select 327401729 orden, 3443 causal_nueva
              from dual
            union all
            select 326962880 orden, 3443 causal_nueva
              from dual
            union all
            select 327119689 orden, 3443 causal_nueva
              from dual
            union all
            select 327176037 orden, 3443 causal_nueva
              from dual
            union all
            select 327405701 orden, 3443 causal_nueva
              from dual
            union all
            select 324609729 orden, 3443 causal_nueva
              from dual
            union all
            select 326461505 orden, 3443 causal_nueva
              from dual
            union all
            select 327085244 orden, 3443 causal_nueva
              from dual
            union all
            select 327403858 orden, 3443 causal_nueva
              from dual
            union all
            select 327402017 orden, 3443 causal_nueva
              from dual
            union all
            select 327404183 orden, 3443 causal_nueva
              from dual
            union all
            select 326864646 orden, 3443 causal_nueva
              from dual
            union all
            select 327411386 orden, 3443 causal_nueva
              from dual
            union all
            select 327401412 orden, 3443 causal_nueva
              from dual
            union all
            select 327100346 orden, 3443 causal_nueva
              from dual
            union all
            select 327411660 orden, 3443 causal_nueva
              from dual
            union all
            select 326682474 orden, 3443 causal_nueva
              from dual
            union all
            select 327402111 orden, 3443 causal_nueva
              from dual
            union all
            select 326850218 orden, 3443 causal_nueva
              from dual
            union all
            select 327404689 orden, 3443 causal_nueva
              from dual
            union all
            select 326847915 orden, 3443 causal_nueva
              from dual
            union all
            select 326465182 orden, 3443 causal_nueva
              from dual
            union all
            select 327556269 orden, 3443 causal_nueva
              from dual
            union all
            select 327169880 orden, 3443 causal_nueva
              from dual
            union all
            select 326846487 orden, 3443 causal_nueva
              from dual
            union all
            select 326668432 orden, 3443 causal_nueva
              from dual
            union all
            select 327401662 orden, 3443 causal_nueva
              from dual
            union all
            select 327401892 orden, 3443 causal_nueva
              from dual
            union all
            select 327404238 orden, 3443 causal_nueva
              from dual
            union all
            select 327405260 orden, 3443 causal_nueva
              from dual
            union all
            select 327402929 orden, 3443 causal_nueva
              from dual
            union all
            select 327406091 orden, 3443 causal_nueva
              from dual
            union all
            select 327401672 orden, 3443 causal_nueva
              from dual
            union all
            select 327404986 orden, 3443 causal_nueva
              from dual
            union all
            select 326100919 orden, 3443 causal_nueva
              from dual
            union all
            select 327404829 orden, 3443 causal_nueva
              from dual
            union all
            select 326869333 orden, 3443 causal_nueva
              from dual
            union all
            select 327411554 orden, 3443 causal_nueva
              from dual
            union all
            select 327405895 orden, 3443 causal_nueva
              from dual
            union all
            select 327403132 orden, 3443 causal_nueva
              from dual
            union all
            select 327402201 orden, 3443 causal_nueva
              from dual
            union all
            select 327401995 orden, 3443 causal_nueva
              from dual
            union all
            select 326846608 orden, 3443 causal_nueva
              from dual
            union all
            select 327556476 orden, 3443 causal_nueva
              from dual
            union all
            select 326668087 orden, 3443 causal_nueva
              from dual
            union all
            select 326854178 orden, 3443 causal_nueva
              from dual
            union all
            select 326843633 orden, 3443 causal_nueva
              from dual
            union all
            select 327175550 orden, 3443 causal_nueva
              from dual
            union all
            select 326669059 orden, 3443 causal_nueva
              from dual
            union all
            select 327411893 orden, 3443 causal_nueva
              from dual
            union all
            select 327405006 orden, 3443 causal_nueva
              from dual
            union all
            select 327401661 orden, 3443 causal_nueva
              from dual
            union all
            select 327402681 orden, 3443 causal_nueva
              from dual
            union all
            select 327405277 orden, 3443 causal_nueva
              from dual
            union all
            select 327403960 orden, 3443 causal_nueva
              from dual
            union all
            select 327180804 orden, 3443 causal_nueva
              from dual
            union all
            select 327405947 orden, 3443 causal_nueva
              from dual
            union all
            select 327411411 orden, 3443 causal_nueva
              from dual
            union all
            select 326857835 orden, 3443 causal_nueva
              from dual
            union all
            select 327404465 orden, 3443 causal_nueva
              from dual
            union all
            select 327404656 orden, 3443 causal_nueva
              from dual
            union all
            select 327411901 orden, 3443 causal_nueva
              from dual
            union all
            select 327401677 orden, 3443 causal_nueva
              from dual
            union all
            select 327171586 orden, 3443 causal_nueva
              from dual
            union all
            select 327403779 orden, 3443 causal_nueva
              from dual
            union all
            select 327404530 orden, 3443 causal_nueva
              from dual
            union all
            select 327402636 orden, 3443 causal_nueva
              from dual
            union all
            select 327404710 orden, 3443 causal_nueva
              from dual
            union all
            select 326447474 orden, 3443 causal_nueva
              from dual
            union all
            select 327411097 orden, 3443 causal_nueva
              from dual
            union all
            select 327405026 orden, 3443 causal_nueva
              from dual
            union all
            select 327404354 orden, 3443 causal_nueva
              from dual
            union all
            select 326848232 orden, 3443 causal_nueva
              from dual
            union all
            select 326962887 orden, 3443 causal_nueva
              from dual
            union all
            select 327405639 orden, 3443 causal_nueva
              from dual
            union all
            select 327402757 orden, 3443 causal_nueva
              from dual
            union all
            select 326865788 orden, 3443 causal_nueva
              from dual
            union all
            select 327402264 orden, 3443 causal_nueva
              from dual
            union all
            select 327401533 orden, 3443 causal_nueva
              from dual
            union all
            select 324687992 orden, 3443 causal_nueva
              from dual
            union all
            select 327405377 orden, 3443 causal_nueva
              from dual
            union all
            select 326850195 orden, 3443 causal_nueva
              from dual
            union all
            select 326856878 orden, 3443 causal_nueva
              from dual
            union all
            select 327121247 orden, 3443 causal_nueva
              from dual
            union all
            select 327405451 orden, 3443 causal_nueva
              from dual
            union all
            select 326446881 orden, 3443 causal_nueva
              from dual
            union all
            select 326862931 orden, 3443 causal_nueva
              from dual
            union all
            select 327169383 orden, 3443 causal_nueva
              from dual
            union all
            select 327175605 orden, 3443 causal_nueva
              from dual
            union all
            select 327407680 orden, 3443 causal_nueva
              from dual
            union all
            select 327404838 orden, 3443 causal_nueva
              from dual
            union all
            select 327401476 orden, 3443 causal_nueva
              from dual
            union all
            select 327402587 orden, 3443 causal_nueva
              from dual
            union all
            select 327085352 orden, 3443 causal_nueva
              from dual
            union all
            select 327403684 orden, 9777 causal_nueva
              from dual
            union all
            select 326868293 orden, 3443 causal_nueva
              from dual
            union all
            select 327402846 orden, 3443 causal_nueva
              from dual
            union all
            select 326668016 orden, 9777 causal_nueva
              from dual
            union all
            select 327405089 orden, 3443 causal_nueva
              from dual
            union all
            select 327401615 orden, 9777 causal_nueva
              from dual
            union all
            select 327402577 orden, 3443 causal_nueva
              from dual
            union all
            select 327401563 orden, 3443 causal_nueva
              from dual
            union all
            select 327404892 orden, 3443 causal_nueva
              from dual
            union all
            select 327402274 orden, 9777 causal_nueva
              from dual
            union all
            select 327556230 orden, 9777 causal_nueva
              from dual
            union all
            select 327402522 orden, 3443 causal_nueva
              from dual
            union all
            select 327401962 orden, 3443 causal_nueva
              from dual
            union all
            select 327401523 orden, 9777 causal_nueva
              from dual
            union all
            select 326465586 orden, 3443 causal_nueva
              from dual
            union all
            select 326445494 orden, 9777 causal_nueva
              from dual
            union all
            select 327401974 orden, 9777 causal_nueva
              from dual
            union all
            select 326195480 orden, 3443 causal_nueva
              from dual
            union all
            select 326962860 orden, 3443 causal_nueva
              from dual
            union all
            select 326858211 orden, 3443 causal_nueva
              from dual
            union all
            select 327175952 orden, 9777 causal_nueva
              from dual
            union all
            select 327402947 orden, 9777 causal_nueva
              from dual
            union all
            select 327404392 orden, 3443 causal_nueva
              from dual
            union all
            select 327405948 orden, 9777 causal_nueva
              from dual
            union all
            select 326688183 orden, 3443 causal_nueva
              from dual
            union all
            select 327403903 orden, 3443 causal_nueva
              from dual
            union all
            select 327411743 orden, 3443 causal_nueva
              from dual
            union all
            select 327556344 orden, 3443 causal_nueva
              from dual
            union all
            select 327401990 orden, 3443 causal_nueva
              from dual
            union all
            select 327404893 orden, 9777 causal_nueva
              from dual
            union all
            select 327405148 orden, 3443 causal_nueva
              from dual
            union all
            select 327179607 orden, 3443 causal_nueva
              from dual
            union all
            select 327402302 orden, 9777 causal_nueva
              from dual
            union all
            select 327411354 orden, 3443 causal_nueva
              from dual
            union all
            select 327411723 orden, 3443 causal_nueva
              from dual
            union all
            select 327176042 orden, 3443 causal_nueva
              from dual
            union all
            select 326846522 orden, 3443 causal_nueva
              from dual
            union all
            select 327405935 orden, 3443 causal_nueva
              from dual
            union all
            select 326850128 orden, 9777 causal_nueva
              from dual
            union all
            select 327405099 orden, 3443 causal_nueva
              from dual
            union all
            select 326115192 orden, 3443 causal_nueva
              from dual
            union all
            select 327556405 orden, 3443 causal_nueva
              from dual
            union all
            select 326962854 orden, 3443 causal_nueva
              from dual
            union all
            select 327401379 orden, 3443 causal_nueva
              from dual
            union all
            select 327403731 orden, 3443 causal_nueva
              from dual
            union all
            select 327411468 orden, 3443 causal_nueva
              from dual
            union all
            select 326844183 orden, 3443 causal_nueva
              from dual
            union all
            select 327402557 orden, 3443 causal_nueva
              from dual
            union all
            select 327178092 orden, 3443 causal_nueva
              from dual
            union all
            select 327305323 orden, 9777 causal_nueva
              from dual
            union all
            select 327195702 orden, 3443 causal_nueva
              from dual
            union all
            select 327120150 orden, 3443 causal_nueva
              from dual
            union all
            select 326860164 orden, 3443 causal_nueva
              from dual
            union all
            select 327405565 orden, 9777 causal_nueva
              from dual
            union all
            select 327403670 orden, 3443 causal_nueva
              from dual
            union all
            select 327402336 orden, 9777 causal_nueva
              from dual
            union all
            select 327411289 orden, 3443 causal_nueva
              from dual
            union all
            select 327402253 orden, 3443 causal_nueva
              from dual
            union all
            select 327403932 orden, 3443 causal_nueva
              from dual
            union all
            select 327201036 orden, 9777 causal_nueva
              from dual
            union all
            select 327402035 orden, 3443 causal_nueva
              from dual
            union all
            select 326445530 orden, 9777 causal_nueva
              from dual
            union all
            select 327171568 orden, 9777 causal_nueva
              from dual
            union all
            select 327085356 orden, 3443 causal_nueva
              from dual
            union all
            select 327098222 orden, 3443 causal_nueva
              from dual
            union all
            select 327404965 orden, 3443 causal_nueva
              from dual
            union all
            select 326868385 orden, 3443 causal_nueva
              from dual
            union all
            select 327403774 orden, 9777 causal_nueva
              from dual
            union all
            select 326668259 orden, 3443 causal_nueva
              from dual
            union all
            select 327196549 orden, 3443 causal_nueva
              from dual
            union all
            select 326859383 orden, 3443 causal_nueva
              from dual
            union all
            select 327406875 orden, 3443 causal_nueva
              from dual
            union all
            select 326978455 orden, 3443 causal_nueva
              from dual
            union all
            select 327405143 orden, 3443 causal_nueva
              from dual
            union all
            select 327401540 orden, 3443 causal_nueva
              from dual
            union all
            select 327404335 orden, 3443 causal_nueva
              from dual
            union all
            select 327411856 orden, 9777 causal_nueva
              from dual
            union all
            select 327175560 orden, 3443 causal_nueva
              from dual
            union all
            select 326668960 orden, 3443 causal_nueva
              from dual
            union all
            select 327402784 orden, 3443 causal_nueva
              from dual
            union all
            select 327174510 orden, 3443 causal_nueva
              from dual
            union all
            select 324612313 orden, 3443 causal_nueva
              from dual
            union all
            select 327403200 orden, 3443 causal_nueva
              from dual
            union all
            select 327556271 orden, 3443 causal_nueva
              from dual
            union all
            select 327404626 orden, 3443 causal_nueva
              from dual
            union all
            select 326462609 orden, 3443 causal_nueva
              from dual
            union all
            select 327403669 orden, 3443 causal_nueva
              from dual
            union all
            select 324900519 orden, 3443 causal_nueva
              from dual
            union all
            select 327404270 orden, 3443 causal_nueva
              from dual
            union all
            select 327204678 orden, 3443 causal_nueva
              from dual
            union all
            select 327556382 orden, 3443 causal_nueva
              from dual
            union all
            select 327412010 orden, 3443 causal_nueva
              from dual
            union all
            select 327405134 orden, 3443 causal_nueva
              from dual
            union all
            select 327404882 orden, 3443 causal_nueva
              from dual
            union all
            select 327405605 orden, 3443 causal_nueva
              from dual
            union all
            select 327411906 orden, 9777 causal_nueva
              from dual
            union all
            select 326102278 orden, 3443 causal_nueva
              from dual
            union all
            select 327411253 orden, 3443 causal_nueva
              from dual
            union all
            select 326868976 orden, 3443 causal_nueva
              from dual
            union all
            select 326861817 orden, 3443 causal_nueva
              from dual
            union all
            select 326863929 orden, 3443 causal_nueva
              from dual
            union all
            select 327177356 orden, 3443 causal_nueva
              from dual
            union all
            select 327305425 orden, 3443 causal_nueva
              from dual
            union all
            select 327402607 orden, 3443 causal_nueva
              from dual
            union all
            select 327169183 orden, 3443 causal_nueva
              from dual
            union all
            select 327401646 orden, 3443 causal_nueva
              from dual
            union all
            select 327411409 orden, 3443 causal_nueva
              from dual
            union all
            select 327402312 orden, 3443 causal_nueva
              from dual
            union all
            select 326861923 orden, 3443 causal_nueva
              from dual
            union all
            select 327401560 orden, 3443 causal_nueva
              from dual
            union all
            select 327401716 orden, 9777 causal_nueva
              from dual
            union all
            select 327405702 orden, 3443 causal_nueva
              from dual
            union all
            select 326195486 orden, 3443 causal_nueva
              from dual
            union all
            select 327403988 orden, 3443 causal_nueva
              from dual
            union all
            select 326340349 orden, 3443 causal_nueva
              from dual
            union all
            select 327402007 orden, 3443 causal_nueva
              from dual
            union all
            select 327404574 orden, 3443 causal_nueva
              from dual
            union all
            select 327403693 orden, 3443 causal_nueva
              from dual
            union all
            select 326668085 orden, 3443 causal_nueva
              from dual
            union all
            select 327404800 orden, 3443 causal_nueva
              from dual
            union all
            select 327404934 orden, 3443 causal_nueva
              from dual
            union all
            select 327402588 orden, 3443 causal_nueva
              from dual
            union all
            select 327401686 orden, 3443 causal_nueva
              from dual
            union all
            select 327178686 orden, 3443 causal_nueva
              from dual
            union all
            select 327411239 orden, 3443 causal_nueva
              from dual
            union all
            select 327406061 orden, 3443 causal_nueva
              from dual
            union all
            select 327407070 orden, 3443 causal_nueva
              from dual
            union all
            select 326844740 orden, 3443 causal_nueva
              from dual
            union all
            select 327170152 orden, 3443 causal_nueva
              from dual
            union all
            select 327405004 orden, 3443 causal_nueva
              from dual
            union all
            select 327401634 orden, 3443 causal_nueva
              from dual
            union all
            select 327402711 orden, 3443 causal_nueva
              from dual
            union all
            select 327403201 orden, 3443 causal_nueva
              from dual
            union all
            select 326669344 orden, 3443 causal_nueva
              from dual
            union all
            select 327187836 orden, 3443 causal_nueva
              from dual
            union all
            select 326845191 orden, 3443 causal_nueva
              from dual
            union all
            select 327405612 orden, 3443 causal_nueva
              from dual
            union all
            select 327119905 orden, 3443 causal_nueva
              from dual
            union all
            select 327408449 orden, 3443 causal_nueva
              from dual
            union all
            select 326862951 orden, 3443 causal_nueva
              from dual
            union all
            select 327402306 orden, 3443 causal_nueva
              from dual
            union all
            select 327403674 orden, 3443 causal_nueva
              from dual
            union all
            select 327401651 orden, 3443 causal_nueva
              from dual
            union all
            select 324609732 orden, 3443 causal_nueva
              from dual
            union all
            select 327410695 orden, 3443 causal_nueva
              from dual
            union all
            select 327556305 orden, 3443 causal_nueva
              from dual
            union all
            select 327402520 orden, 3443 causal_nueva
              from dual
            union all
            select 327411478 orden, 3443 causal_nueva
              from dual
            union all
            select 327405388 orden, 3443 causal_nueva
              from dual
            union all
            select 326940812 orden, 3443 causal_nueva
              from dual
            union all
            select 327171381 orden, 3443 causal_nueva
              from dual
            union all
            select 327406331 orden, 3443 causal_nueva
              from dual
            union all
            select 327404664 orden, 3443 causal_nueva
              from dual
            union all
            select 327403190 orden, 3443 causal_nueva
              from dual
            union all
            select 327405801 orden, 3443 causal_nueva
              from dual
            union all
            select 326865039 orden, 3443 causal_nueva
              from dual
            union all
            select 327173173 orden, 3443 causal_nueva
              from dual
            union all
            select 326101942 orden, 3443 causal_nueva
              from dual
            union all
            select 327402019 orden, 9777 causal_nueva
              from dual
            union all
            select 327406084 orden, 3443 causal_nueva
              from dual
            union all
            select 327169490 orden, 3443 causal_nueva
              from dual
            union all
            select 326843754 orden, 3443 causal_nueva
              from dual
            union all
            select 326844845 orden, 3443 causal_nueva
              from dual
            union all
            select 327405752 orden, 3443 causal_nueva
              from dual
            union all
            select 327403667 orden, 3443 causal_nueva
              from dual
            union all
            select 327404273 orden, 3443 causal_nueva
              from dual
            union all
            select 326962888 orden, 3443 causal_nueva
              from dual
            union all
            select 327405540 orden, 3443 causal_nueva
              from dual
            union all
            select 327556276 orden, 3443 causal_nueva
              from dual
            union all
            select 326668975 orden, 3443 causal_nueva
              from dual
            union all
            select 327405469 orden, 3443 causal_nueva
              from dual
            union all
            select 327404823 orden, 3443 causal_nueva
              from dual
            union all
            select 326105667 orden, 3443 causal_nueva
              from dual
            union all
            select 326446305 orden, 3443 causal_nueva
              from dual
            union all
            select 327403977 orden, 3443 causal_nueva
              from dual
            union all
            select 327403737 orden, 3443 causal_nueva
              from dual
            union all
            select 327121224 orden, 3443 causal_nueva
              from dual
            union all
            select 327404365 orden, 3443 causal_nueva
              from dual
            union all
            select 327404324 orden, 3443 causal_nueva
              from dual
            union all
            select 327411596 orden, 3443 causal_nueva
              from dual
            union all
            select 327179534 orden, 3443 causal_nueva
              from dual
            union all
            select 327409481 orden, 3443 causal_nueva
              from dual
            union all
            select 327411781 orden, 3443 causal_nueva
              from dual
            union all
            select 327411881 orden, 3443 causal_nueva
              from dual
            union all
            select 327401693 orden, 3443 causal_nueva
              from dual
            union all
            select 327179938 orden, 3443 causal_nueva
              from dual
            union all
            select 327404891 orden, 3443 causal_nueva
              from dual
            union all
            select 327174610 orden, 3443 causal_nueva
              from dual
            union all
            select 326846694 orden, 3443 causal_nueva
              from dual
            union all
            select 326866678 orden, 3443 causal_nueva
              from dual
            union all
            select 327193125 orden, 3443 causal_nueva
              from dual
            union all
            select 327404767 orden, 3443 causal_nueva
              from dual
            union all
            select 326850154 orden, 3443 causal_nueva
              from dual
            union all
            select 327175638 orden, 3443 causal_nueva
              from dual
            union all
            select 327173255 orden, 3443 causal_nueva
              from dual
            union all
            select 327404989 orden, 3443 causal_nueva
              from dual
            union all
            select 327404757 orden, 3443 causal_nueva
              from dual
            union all
            select 327405046 orden, 3443 causal_nueva
              from dual
            union all
            select 326847706 orden, 3443 causal_nueva
              from dual
            union all
            select 327403928 orden, 3443 causal_nueva
              from dual
            union all
            select 326110989 orden, 9777 causal_nueva
              from dual
            union all
            select 327411294 orden, 3443 causal_nueva
              from dual
            union all
            select 327119573 orden, 3443 causal_nueva
              from dual
            union all
            select 327401885 orden, 3443 causal_nueva
              from dual
            union all
            select 327405685 orden, 3443 causal_nueva
              from dual
            union all
            select 326843963 orden, 3443 causal_nueva
              from dual
            union all
            select 327405312 orden, 3443 causal_nueva
              from dual
            union all
            select 326863395 orden, 3443 causal_nueva
              from dual
            union all
            select 327172040 orden, 3443 causal_nueva
              from dual
            union all
            select 327402324 orden, 3443 causal_nueva
              from dual
            union all
            select 327405273 orden, 3443 causal_nueva
              from dual
            union all
            select 326869457 orden, 3443 causal_nueva
              from dual
            union all
            select 327092109 orden, 3443 causal_nueva
              from dual
            union all
            select 327411206 orden, 3443 causal_nueva
              from dual
            union all
            select 327199911 orden, 3443 causal_nueva
              from dual
            union all
            select 327169822 orden, 3443 causal_nueva
              from dual
            union all
            select 326668252 orden, 3443 causal_nueva
              from dual
            union all
            select 327402805 orden, 3443 causal_nueva
              from dual
            union all
            select 326859916 orden, 3443 causal_nueva
              from dual
            union all
            select 327412003 orden, 3443 causal_nueva
              from dual
            union all
            select 327405717 orden, 9777 causal_nueva
              from dual
            union all
            select 326446725 orden, 3443 causal_nueva
              from dual
            union all
            select 327405124 orden, 3443 causal_nueva
              from dual
            union all
            select 327120581 orden, 3443 causal_nueva
              from dual
            union all
            select 327401545 orden, 3443 causal_nueva
              from dual
            union all
            select 327179203 orden, 3443 causal_nueva
              from dual
            union all
            select 327173065 orden, 3443 causal_nueva
              from dual
            union all
            select 327106738 orden, 3443 causal_nueva
              from dual
            union all
            select 327402719 orden, 3443 causal_nueva
              from dual
            union all
            select 327411214 orden, 3443 causal_nueva
              from dual
            union all
            select 327173078 orden, 3443 causal_nueva
              from dual
            union all
            select 327404537 orden, 3443 causal_nueva
              from dual
            union all
            select 327180714 orden, 3443 causal_nueva
              from dual
            union all
            select 327177358 orden, 3443 causal_nueva
              from dual
            union all
            select 327405115 orden, 3443 causal_nueva
              from dual
            union all
            select 327404935 orden, 3443 causal_nueva
              from dual
            union all
            select 326962857 orden, 3443 causal_nueva
              from dual
            union all
            select 326860151 orden, 3443 causal_nueva
              from dual
            union all
            select 327402062 orden, 3443 causal_nueva
              from dual
            union all
            select 327085433 orden, 3443 causal_nueva
              from dual
            union all
            select 327412016 orden, 3443 causal_nueva
              from dual
            union all
            select 327403915 orden, 3443 causal_nueva
              from dual
            union all
            select 327404582 orden, 3443 causal_nueva
              from dual
            union all
            select 327120413 orden, 3443 causal_nueva
              from dual
            union all
            select 327405060 orden, 3443 causal_nueva
              from dual
            union all
            select 327404198 orden, 3443 causal_nueva
              from dual
            union all
            select 326859772 orden, 3443 causal_nueva
              from dual
            union all
            select 327403862 orden, 3443 causal_nueva
              from dual
            union all
            select 326865789 orden, 3443 causal_nueva
              from dual
            union all
            select 327404105 orden, 3443 causal_nueva
              from dual
            union all
            select 327410689 orden, 3443 causal_nueva
              from dual
            union all
            select 327401636 orden, 3443 causal_nueva
              from dual
            union all
            select 327404878 orden, 3443 causal_nueva
              from dual
            union all
            select 327411295 orden, 3443 causal_nueva
              from dual
            union all
            select 326668980 orden, 3443 causal_nueva
              from dual
            union all
            select 327402559 orden, 3443 causal_nueva
              from dual
            union all
            select 327403718 orden, 3443 causal_nueva
              from dual
            union all
            select 326845290 orden, 3443 causal_nueva
              from dual
            union all
            select 327402708 orden, 3443 causal_nueva
              from dual
            union all
            select 327181266 orden, 3443 causal_nueva
              from dual
            union all
            select 327099735 orden, 3443 causal_nueva
              from dual
            union all
            select 326668007 orden, 3443 causal_nueva
              from dual
            union all
            select 326462805 orden, 3443 causal_nueva
              from dual
            union all
            select 327405494 orden, 3443 causal_nueva
              from dual
            union all
            select 327402291 orden, 3443 causal_nueva
              from dual
            union all
            select 326464083 orden, 3443 causal_nueva
              from dual
            union all
            select 326860221 orden, 3443 causal_nueva
              from dual
            union all
            select 327556403 orden, 3443 causal_nueva
              from dual
            union all
            select 327403215 orden, 3443 causal_nueva
              from dual
            union all
            select 327402540 orden, 3443 causal_nueva
              from dual
            union all
            select 327402316 orden, 3443 causal_nueva
              from dual
            union all
            select 327404773 orden, 3443 causal_nueva
              from dual
            union all
            select 327405436 orden, 3443 causal_nueva
              from dual
            union all
            select 327411377 orden, 3443 causal_nueva
              from dual
            union all
            select 326865981 orden, 3443 causal_nueva
              from dual
            union all
            select 327404120 orden, 3443 causal_nueva
              from dual
            union all
            select 327180809 orden, 3443 causal_nueva
              from dual
            union all
            select 326668306 orden, 3443 causal_nueva
              from dual
            union all
            select 327404403 orden, 3443 causal_nueva
              from dual
            union all
            select 327085406 orden, 9777 causal_nueva
              from dual
            union all
            select 326100955 orden, 3443 causal_nueva
              from dual
            union all
            select 327403738 orden, 9777 causal_nueva
              from dual
            union all
            select 327401477 orden, 3443 causal_nueva
              from dual
            union all
            select 326868542 orden, 3443 causal_nueva
              from dual
            union all
            select 327403231 orden, 3443 causal_nueva
              from dual
            union all
            select 327402158 orden, 3443 causal_nueva
              from dual
            union all
            select 327411761 orden, 3443 causal_nueva
              from dual
            union all
            select 327403273 orden, 3443 causal_nueva
              from dual
            union all
            select 326843793 orden, 3443 causal_nueva
              from dual
            union all
            select 327402117 orden, 3443 causal_nueva
              from dual
            union all
            select 326863997 orden, 3443 causal_nueva
              from dual
            union all
            select 327204646 orden, 3443 causal_nueva
              from dual
            union all
            select 327405501 orden, 3443 causal_nueva
              from dual
            union all
            select 326859243 orden, 3443 causal_nueva
              from dual
            union all
            select 327189798 orden, 3443 causal_nueva
              from dual
            union all
            select 327401498 orden, 3443 causal_nueva
              from dual
            union all
            select 327403981 orden, 3443 causal_nueva
              from dual
            union all
            select 327401420 orden, 3443 causal_nueva
              from dual
            union all
            select 327405642 orden, 3443 causal_nueva
              from dual
            union all
            select 327409080 orden, 3443 causal_nueva
              from dual
            union all
            select 327409397 orden, 3443 causal_nueva
              from dual
            union all
            select 327404332 orden, 3443 causal_nueva
              from dual
            union all
            select 326861800 orden, 3443 causal_nueva
              from dual
            union all
            select 326445930 orden, 3443 causal_nueva
              from dual
            union all
            select 327411307 orden, 3443 causal_nueva
              from dual
            union all
            select 326865749 orden, 3443 causal_nueva
              from dual
            union all
            select 327408042 orden, 3443 causal_nueva
              from dual
            union all
            select 327411955 orden, 9777 causal_nueva
              from dual
            union all
            select 327401747 orden, 3443 causal_nueva
              from dual
            union all
            select 327402843 orden, 3443 causal_nueva
              from dual
            union all
            select 327411769 orden, 3443 causal_nueva
              from dual
            union all
            select 327405695 orden, 3443 causal_nueva
              from dual
            union all
            select 327169796 orden, 3443 causal_nueva
              from dual
            union all
            select 326940373 orden, 3443 causal_nueva
              from dual
            union all
            select 326843620 orden, 3443 causal_nueva
              from dual
            union all
            select 326843637 orden, 3443 causal_nueva
              from dual
            union all
            select 326445466 orden, 3443 causal_nueva
              from dual
            union all
            select 327401598 orden, 3443 causal_nueva
              from dual
            union all
            select 327173265 orden, 3443 causal_nueva
              from dual
            union all
            select 327175630 orden, 3443 causal_nueva
              from dual
            union all
            select 327404694 orden, 3443 causal_nueva
              from dual
            union all
            select 327405678 orden, 9777 causal_nueva
              from dual
            union all
            select 326843643 orden, 3443 causal_nueva
              from dual
            union all
            select 327403668 orden, 9777 causal_nueva
              from dual
            union all
            select 327402528 orden, 3443 causal_nueva
              from dual
            union all
            select 327404396 orden, 3443 causal_nueva
              from dual
            union all
            select 327406819 orden, 9777 causal_nueva
              from dual
            union all
            select 327411634 orden, 9777 causal_nueva
              from dual
            union all
            select 326858662 orden, 3443 causal_nueva
              from dual
            union all
            select 327100452 orden, 3443 causal_nueva
              from dual
            union all
            select 327187499 orden, 3443 causal_nueva
              from dual
            union all
            select 327403087 orden, 9777 causal_nueva
              from dual
            union all
            select 327170781 orden, 3443 causal_nueva
              from dual
            union all
            select 326668964 orden, 3443 causal_nueva
              from dual
            union all
            select 327404797 orden, 3443 causal_nueva
              from dual
            union all
            select 327198117 orden, 3443 causal_nueva
              from dual
            union all
            select 327092369 orden, 3443 causal_nueva
              from dual
            union all
            select 327405481 orden, 3443 causal_nueva
              from dual
            union all
            select 327405592 orden, 9777 causal_nueva
              from dual
            union all
            select 327401706 orden, 3443 causal_nueva
              from dual
            union all
            select 326962904 orden, 3443 causal_nueva
              from dual
            union all
            select 326454856 orden, 3443 causal_nueva
              from dual
            union all
            select 327403711 orden, 9777 causal_nueva
              from dual
            union all
            select 327409767 orden, 3443 causal_nueva
              from dual
            union all
            select 327411685 orden, 3443 causal_nueva
              from dual
            union all
            select 326861003 orden, 9777 causal_nueva
              from dual
            union all
            select 327410943 orden, 9777 causal_nueva
              from dual
            union all
            select 326668017 orden, 3443 causal_nueva
              from dual
            union all
            select 326668431 orden, 3443 causal_nueva
              from dual
            union all
            select 326850199 orden, 3443 causal_nueva
              from dual
            union all
            select 327174465 orden, 9777 causal_nueva
              from dual
            union all
            select 327405140 orden, 9777 causal_nueva
              from dual
            union all
            select 327405311 orden, 3443 causal_nueva
              from dual
            union all
            select 327411204 orden, 9777 causal_nueva
              from dual
            union all
            select 326843629 orden, 3443 causal_nueva
              from dual
            union all
            select 327411238 orden, 9777 causal_nueva
              from dual
            union all
            select 327402146 orden, 3443 causal_nueva
              from dual
            union all
            select 326865791 orden, 3443 causal_nueva
              from dual
            union all
            select 327175698 orden, 9777 causal_nueva
              from dual
            union all
            select 326865787 orden, 3443 causal_nueva
              from dual
            union all
            select 327405396 orden, 3443 causal_nueva
              from dual
            union all
            select 327403620 orden, 3443 causal_nueva
              from dual
            union all
            select 326859911 orden, 3443 causal_nueva
              from dual
            union all
            select 327191061 orden, 3443 causal_nueva
              from dual
            union all
            select 326850145 orden, 3443 causal_nueva
              from dual
            union all
            select 327171244 orden, 3443 causal_nueva
              from dual
            union all
            select 327410729 orden, 3443 causal_nueva
              from dual
            union all
            select 327172830 orden, 3443 causal_nueva
              from dual
            union all
            select 326859080 orden, 3443 causal_nueva
              from dual
            union all
            select 327410902 orden, 3443 causal_nueva
              from dual
            union all
            select 327556237 orden, 3443 causal_nueva
              from dual
            union all
            select 327177940 orden, 3443 causal_nueva
              from dual
            union all
            select 327405067 orden, 3443 causal_nueva
              from dual
            union all
            select 327404709 orden, 3443 causal_nueva
              from dual
            union all
            select 326859244 orden, 3443 causal_nueva
              from dual
            union all
            select 327174552 orden, 9777 causal_nueva
              from dual
            union all
            select 326668965 orden, 3443 causal_nueva
              from dual
            union all
            select 327119692 orden, 3443 causal_nueva
              from dual
            union all
            select 327401650 orden, 3443 causal_nueva
              from dual
            union all
            select 327411428 orden, 3443 causal_nueva
              from dual
            union all
            select 326445501 orden, 3443 causal_nueva
              from dual
            union all
            select 327410944 orden, 3443 causal_nueva
              from dual
            union all
            select 327405280 orden, 3443 causal_nueva
              from dual
            union all
            select 327405889 orden, 3443 causal_nueva
              from dual
            union all
            select 326465351 orden, 3443 causal_nueva
              from dual
            union all
            select 327402737 orden, 3443 causal_nueva
              from dual
            union all
            select 326866465 orden, 3443 causal_nueva
              from dual
            union all
            select 327401691 orden, 3443 causal_nueva
              from dual
            union all
            select 327404124 orden, 3443 causal_nueva
              from dual
            union all
            select 327556336 orden, 3443 causal_nueva
              from dual
            union all
            select 327402732 orden, 3443 causal_nueva
              from dual
            union all
            select 327409425 orden, 3443 causal_nueva
              from dual
            union all
            select 327401459 orden, 3443 causal_nueva
              from dual
            union all
            select 326861362 orden, 3443 causal_nueva
              from dual
            union all
            select 327401612 orden, 3443 causal_nueva
              from dual
            union all
            select 326850433 orden, 3443 causal_nueva
              from dual
            union all
            select 327405795 orden, 9777 causal_nueva
              from dual
            union all
            select 326445590 orden, 3443 causal_nueva
              from dual
            union all
            select 327175800 orden, 3443 causal_nueva
              from dual
            union all
            select 327402695 orden, 3443 causal_nueva
              from dual
            union all
            select 326447372 orden, 3443 causal_nueva
              from dual
            union all
            select 327196989 orden, 9777 causal_nueva
              from dual
            union all
            select 327405536 orden, 3443 causal_nueva
              from dual
            union all
            select 327411221 orden, 3443 causal_nueva
              from dual
            union all
            select 326860516 orden, 3443 causal_nueva
              from dual
            union all
            select 327403898 orden, 9777 causal_nueva
              from dual
            union all
            select 327402499 orden, 3443 causal_nueva
              from dual
            union all
            select 326868350 orden, 3443 causal_nueva
              from dual
            union all
            select 327401906 orden, 3443 causal_nueva
              from dual
            union all
            select 327404333 orden, 3443 causal_nueva
              from dual
            union all
            select 327085166 orden, 9777 causal_nueva
              from dual
            union all
            select 327411767 orden, 3443 causal_nueva
              from dual
            union all
            select 326668970 orden, 9777 causal_nueva
              from dual
            union all
            select 327410725 orden, 3443 causal_nueva
              from dual
            union all
            select 327556474 orden, 3443 causal_nueva
              from dual
            union all
            select 327170104 orden, 3443 causal_nueva
              from dual
            union all
            select 326446440 orden, 3443 causal_nueva
              from dual
            union all
            select 327405291 orden, 3443 causal_nueva
              from dual
            union all
            select 327405184 orden, 3443 causal_nueva
              from dual
            union all
            select 326668044 orden, 3443 causal_nueva
              from dual
            union all
            select 327402730 orden, 3443 causal_nueva
              from dual
            union all
            select 327406004 orden, 3443 causal_nueva
              from dual
            union all
            select 324524802 orden, 3443 causal_nueva
              from dual
            union all
            select 327411967 orden, 3443 causal_nueva
              from dual
            union all
            select 326867571 orden, 3443 causal_nueva
              from dual
            union all
            select 327404550 orden, 9777 causal_nueva
              from dual
            union all
            select 327406057 orden, 3443 causal_nueva
              from dual
            union all
            select 327401742 orden, 3443 causal_nueva
              from dual
            union all
            select 327556310 orden, 3443 causal_nueva
              from dual
            union all
            select 326856847 orden, 3443 causal_nueva
              from dual
            union all
            select 327405037 orden, 3443 causal_nueva
              from dual
            union all
            select 326463990 orden, 3443 causal_nueva
              from dual
            union all
            select 327556225 orden, 3443 causal_nueva
              from dual
            union all
            select 327121225 orden, 3443 causal_nueva
              from dual
            union all
            select 326940195 orden, 3443 causal_nueva
              from dual
            union all
            select 327184705 orden, 3443 causal_nueva
              from dual
            union all
            select 327402176 orden, 3443 causal_nueva
              from dual
            union all
            select 326866083 orden, 3443 causal_nueva
              from dual
            union all
            select 327175697 orden, 3443 causal_nueva
              from dual
            union all
            select 326867657 orden, 3443 causal_nueva
              from dual
            union all
            select 327405498 orden, 3443 causal_nueva
              from dual
            union all
            select 327556447 orden, 3443 causal_nueva
              from dual
            union all
            select 327119934 orden, 3443 causal_nueva
              from dual
            union all
            select 327411774 orden, 3443 causal_nueva
              from dual
            union all
            select 326843703 orden, 3443 causal_nueva
              from dual
            union all
            select 326867531 orden, 3443 causal_nueva
              from dual
            union all
            select 327402122 orden, 9777 causal_nueva
              from dual
            union all
            select 327119864 orden, 3443 causal_nueva
              from dual
            union all
            select 327404990 orden, 3443 causal_nueva
              from dual
            union all
            select 327556393 orden, 3443 causal_nueva
              from dual
            union all
            select 326844775 orden, 3443 causal_nueva
              from dual
            union all
            select 327404959 orden, 3443 causal_nueva
              from dual
            union all
            select 327405815 orden, 3443 causal_nueva
              from dual
            union all
            select 327174656 orden, 3443 causal_nueva
              from dual
            union all
            select 327403870 orden, 3443 causal_nueva
              from dual
            union all
            select 327405156 orden, 9777 causal_nueva
              from dual
            union all
            select 327178103 orden, 3443 causal_nueva
              from dual
            union all
            select 327411927 orden, 3443 causal_nueva
              from dual
            union all
            select 326667972 orden, 3443 causal_nueva
              from dual
            union all
            select 327169392 orden, 3443 causal_nueva
              from dual
            union all
            select 327183695 orden, 3443 causal_nueva
              from dual
            union all
            select 326940509 orden, 3443 causal_nueva
              from dual
            union all
            select 326668955 orden, 3443 causal_nueva
              from dual
            union all
            select 327404339 orden, 3443 causal_nueva
              from dual
            union all
            select 327170089 orden, 3443 causal_nueva
              from dual
            union all
            select 327405108 orden, 3443 causal_nueva
              from dual
            union all
            select 326845088 orden, 3443 causal_nueva
              from dual
            union all
            select 327085212 orden, 9777 causal_nueva
              from dual
            union all
            select 327411299 orden, 3443 causal_nueva
              from dual
            union all
            select 326843622 orden, 3443 causal_nueva
              from dual
            union all
            select 327402632 orden, 3443 causal_nueva
              from dual
            union all
            select 327169474 orden, 3443 causal_nueva
              from dual
            union all
            select 327411900 orden, 9777 causal_nueva
              from dual
            union all
            select 327404854 orden, 3443 causal_nueva
              from dual
            union all
            select 326962877 orden, 3443 causal_nueva
              from dual
            union all
            select 326858618 orden, 3443 causal_nueva
              from dual
            union all
            select 327411872 orden, 3443 causal_nueva
              from dual
            union all
            select 327402143 orden, 3443 causal_nueva
              from dual
            union all
            select 326458992 orden, 3443 causal_nueva
              from dual
            union all
            select 327174615 orden, 9777 causal_nueva
              from dual
            union all
            select 327173249 orden, 3443 causal_nueva
              from dual
            union all
            select 327405672 orden, 3443 causal_nueva
              from dual
            union all
            select 327410720 orden, 3443 causal_nueva
              from dual
            union all
            select 327405647 orden, 3443 causal_nueva
              from dual
            union all
            select 326979757 orden, 3443 causal_nueva
              from dual
            union all
            select 327403753 orden, 9777 causal_nueva
              from dual
            union all
            select 327403599 orden, 3443 causal_nueva
              from dual
            union all
            select 326856840 orden, 3443 causal_nueva
              from dual
            union all
            select 327119574 orden, 3443 causal_nueva
              from dual
            union all
            select 326668434 orden, 3443 causal_nueva
              from dual
            union all
            select 327404492 orden, 3443 causal_nueva
              from dual
            union all
            select 327402992 orden, 3443 causal_nueva
              from dual
            union all
            select 326850436 orden, 3443 causal_nueva
              from dual
            union all
            select 327403247 orden, 9777 causal_nueva
              from dual
            union all
            select 326445570 orden, 3443 causal_nueva
              from dual
            union all
            select 327556383 orden, 3443 causal_nueva
              from dual
            union all
            select 327411023 orden, 3443 causal_nueva
              from dual
            union all
            select 327404425 orden, 3443 causal_nueva
              from dual
            union all
            select 327402870 orden, 3443 causal_nueva
              from dual
            union all
            select 327404706 orden, 3443 causal_nueva
              from dual
            union all
            select 327203232 orden, 9777 causal_nueva
              from dual
            union all
            select 327404271 orden, 3443 causal_nueva
              from dual
            union all
            select 327403638 orden, 3443 causal_nueva
              from dual
            union all
            select 327402866 orden, 3443 causal_nueva
              from dual
            union all
            select 327401907 orden, 9777 causal_nueva
              from dual
            union all
            select 327404947 orden, 3443 causal_nueva
              from dual
            union all
            select 326462733 orden, 3443 causal_nueva
              from dual
            union all
            select 327402178 orden, 9777 causal_nueva
              from dual
            union all
            select 327201273 orden, 3443 causal_nueva
              from dual
            union all
            select 326848267 orden, 3443 causal_nueva
              from dual
            union all
            select 326668037 orden, 3443 causal_nueva
              from dual
            union all
            select 327402088 orden, 3443 causal_nueva
              from dual
            union all
            select 326861412 orden, 3443 causal_nueva
              from dual
            union all
            select 326978803 orden, 3443 causal_nueva
              from dual
            union all
            select 326845681 orden, 3443 causal_nueva
              from dual
            union all
            select 327556433 orden, 3443 causal_nueva
              from dual
            union all
            select 327401852 orden, 3443 causal_nueva
              from dual
            union all
            select 326850442 orden, 3443 causal_nueva
              from dual
            union all
            select 327180821 orden, 3443 causal_nueva
              from dual
            union all
            select 327181015 orden, 3443 causal_nueva
              from dual
            union all
            select 327188284 orden, 3443 causal_nueva
              from dual
            union all
            select 324612301 orden, 3443 causal_nueva
              from dual
            union all
            select 326850210 orden, 3443 causal_nueva
              from dual
            union all
            select 327178394 orden, 3443 causal_nueva
              from dual
            union all
            select 327408961 orden, 3443 causal_nueva
              from dual
            union all
            select 327556327 orden, 9777 causal_nueva
              from dual
            union all
            select 327402239 orden, 3443 causal_nueva
              from dual
            union all
            select 327402848 orden, 3443 causal_nueva
              from dual
            union all
            select 327175714 orden, 3443 causal_nueva
              from dual
            union all
            select 327411251 orden, 3443 causal_nueva
              from dual
            union all
            select 327197688 orden, 9777 causal_nueva
              from dual
            union all
            select 327403175 orden, 3443 causal_nueva
              from dual
            union all
            select 327402242 orden, 3443 causal_nueva
              from dual
            union all
            select 327404134 orden, 3443 causal_nueva
              from dual
            union all
            select 327169737 orden, 3443 causal_nueva
              from dual
            union all
            select 327556242 orden, 3443 causal_nueva
              from dual
            union all
            select 327404979 orden, 3443 causal_nueva
              from dual
            union all
            select 327194256 orden, 3443 causal_nueva
              from dual
            union all
            select 326102237 orden, 3443 causal_nueva
              from dual
            union all
            select 326445481 orden, 3443 causal_nueva
              from dual
            union all
            select 327405500 orden, 3443 causal_nueva
              from dual
            union all
            select 327085342 orden, 9777 causal_nueva
              from dual
            union all
            select 327180674 orden, 3443 causal_nueva
              from dual
            union all
            select 327405285 orden, 9777 causal_nueva
              from dual
            union all
            select 326668213 orden, 3443 causal_nueva
              from dual
            union all
            select 326859237 orden, 3443 causal_nueva
              from dual
            union all
            select 326679401 orden, 3443 causal_nueva
              from dual
            union all
            select 327411686 orden, 9777 causal_nueva
              from dual
            union all
            select 326113749 orden, 3443 causal_nueva
              from dual
            union all
            select 327411945 orden, 3443 causal_nueva
              from dual
            union all
            select 326668978 orden, 3443 causal_nueva
              from dual
            union all
            select 326850140 orden, 3443 causal_nueva
              from dual
            union all
            select 327405442 orden, 3443 causal_nueva
              from dual
            union all
            select 327405595 orden, 3443 causal_nueva
              from dual
            union all
            select 326445486 orden, 3443 causal_nueva
              from dual
            union all
            select 327404795 orden, 3443 causal_nueva
              from dual
            union all
            select 326867771 orden, 3443 causal_nueva
              from dual
            union all
            select 327556296 orden, 3443 causal_nueva
              from dual
            union all
            select 327401507 orden, 3443 causal_nueva
              from dual
            union all
            select 327405289 orden, 3443 causal_nueva
              from dual
            union all
            select 326682476 orden, 3443 causal_nueva
              from dual
            union all
            select 327411810 orden, 3443 causal_nueva
              from dual
            union all
            select 327402189 orden, 3443 causal_nueva
              from dual
            union all
            select 327401637 orden, 3443 causal_nueva
              from dual
            union all
            select 326861078 orden, 3443 causal_nueva
              from dual
            union all
            select 327404804 orden, 3443 causal_nueva
              from dual
            union all
            select 327405878 orden, 3443 causal_nueva
              from dual
            union all
            select 327411637 orden, 3443 causal_nueva
              from dual
            union all
            select 327401898 orden, 3443 causal_nueva
              from dual
            union all
            select 327405467 orden, 9777 causal_nueva
              from dual
            union all
            select 327402225 orden, 3443 causal_nueva
              from dual
            union all
            select 327404386 orden, 3443 causal_nueva
              from dual
            union all
            select 327119673 orden, 3443 causal_nueva
              from dual
            union all
            select 326866608 orden, 3443 causal_nueva
              from dual
            union all
            select 327184874 orden, 9777 causal_nueva
              from dual
            union all
            select 327099296 orden, 3443 causal_nueva
              from dual
            union all
            select 326856881 orden, 3443 causal_nueva
              from dual
            union all
            select 327120748 orden, 3443 causal_nueva
              from dual
            union all
            select 327408655 orden, 9777 causal_nueva
              from dual
            union all
            select 327401936 orden, 3443 causal_nueva
              from dual
            union all
            select 327405654 orden, 3443 causal_nueva
              from dual
            union all
            select 327411932 orden, 9777 causal_nueva
              from dual
            union all
            select 327401896 orden, 3443 causal_nueva
              from dual
            union all
            select 326859677 orden, 3443 causal_nueva
              from dual
            union all
            select 327411845 orden, 3443 causal_nueva
              from dual
            union all
            select 327405110 orden, 3443 causal_nueva
              from dual
            union all
            select 326843640 orden, 3443 causal_nueva
              from dual
            union all
            select 327402869 orden, 3443 causal_nueva
              from dual
            union all
            select 327402236 orden, 3443 causal_nueva
              from dual
            union all
            select 327405397 orden, 3443 causal_nueva
              from dual
            union all
            select 327405739 orden, 3443 causal_nueva
              from dual
            union all
            select 327405360 orden, 3443 causal_nueva
              from dual
            union all
            select 327401678 orden, 3443 causal_nueva
              from dual
            union all
            select 327405708 orden, 3443 causal_nueva
              from dual
            union all
            select 327179464 orden, 3443 causal_nueva
              from dual
            union all
            select 327404234 orden, 3443 causal_nueva
              from dual
            union all
            select 327404617 orden, 3443 causal_nueva
              from dual
            union all
            select 327404930 orden, 3443 causal_nueva
              from dual
            union all
            select 327175658 orden, 9777 causal_nueva
              from dual
            union all
            select 326858760 orden, 3443 causal_nueva
              from dual
            union all
            select 326848191 orden, 3443 causal_nueva
              from dual
            union all
            select 327404031 orden, 3443 causal_nueva
              from dual
            union all
            select 327405609 orden, 3443 causal_nueva
              from dual
            union all
            select 327405310 orden, 3443 causal_nueva
              from dual
            union all
            select 327404501 orden, 3443 causal_nueva
              from dual
            union all
            select 326668084 orden, 3443 causal_nueva
              from dual
            union all
            select 327402261 orden, 3443 causal_nueva
              from dual
            union all
            select 327179835 orden, 3443 causal_nueva
              from dual
            union all
            select 327401337 orden, 3443 causal_nueva
              from dual
            union all
            select 327119806 orden, 3443 causal_nueva
              from dual
            union all
            select 327403038 orden, 3443 causal_nueva
              from dual
            union all
            select 327404254 orden, 3443 causal_nueva
              from dual
            union all
            select 327412019 orden, 3443 causal_nueva
              from dual
            union all
            select 326867706 orden, 3443 causal_nueva
              from dual
            union all
            select 327197125 orden, 9777 causal_nueva
              from dual
            union all
            select 327410746 orden, 9777 causal_nueva
              from dual
            union all
            select 327403141 orden, 3443 causal_nueva
              from dual
            union all
            select 327174579 orden, 9777 causal_nueva
              from dual
            union all
            select 327404676 orden, 3443 causal_nueva
              from dual
            union all
            select 327180819 orden, 3443 causal_nueva
              from dual
            union all
            select 327119702 orden, 3443 causal_nueva
              from dual
            union all
            select 326860656 orden, 3443 causal_nueva
              from dual
            union all
            select 326869508 orden, 3443 causal_nueva
              from dual
            union all
            select 327402823 orden, 3443 causal_nueva
              from dual
            union all
            select 327404001 orden, 3443 causal_nueva
              from dual
            union all
            select 326445618 orden, 9777 causal_nueva
              from dual
            union all
            select 326859240 orden, 3443 causal_nueva
              from dual
            union all
            select 327405718 orden, 3443 causal_nueva
              from dual
            union all
            select 326859391 orden, 3443 causal_nueva
              from dual
            union all
            select 326100514 orden, 9777 causal_nueva
              from dual
            union all
            select 327401616 orden, 3443 causal_nueva
              from dual
            union all
            select 327402145 orden, 3443 causal_nueva
              from dual
            union all
            select 327411639 orden, 9777 causal_nueva
              from dual
            union all
            select 327170466 orden, 3443 causal_nueva
              from dual
            union all
            select 327403003 orden, 3443 causal_nueva
              from dual
            union all
            select 327409400 orden, 3443 causal_nueva
              from dual
            union all
            select 327402484 orden, 3443 causal_nueva
              from dual
            union all
            select 327119675 orden, 3443 causal_nueva
              from dual
            union all
            select 326854288 orden, 3443 causal_nueva
              from dual
            union all
            select 327406040 orden, 3443 causal_nueva
              from dual
            union all
            select 327401487 orden, 9777 causal_nueva
              from dual
            union all
            select 327404446 orden, 9777 causal_nueva
              from dual
            union all
            select 326445499 orden, 3443 causal_nueva
              from dual
            union all
            select 324900357 orden, 3443 causal_nueva
              from dual
            union all
            select 327403962 orden, 3443 causal_nueva
              from dual
            union all
            select 327402875 orden, 3443 causal_nueva
              from dual
            union all
            select 326850223 orden, 3443 causal_nueva
              from dual
            union all
            select 327169461 orden, 3443 causal_nueva
              from dual
            union all
            select 326667996 orden, 3443 causal_nueva
              from dual
            union all
            select 327405468 orden, 3443 causal_nueva
              from dual
            union all
            select 327200034 orden, 9777 causal_nueva
              from dual
            union all
            select 326850156 orden, 3443 causal_nueva
              from dual
            union all
            select 327404758 orden, 3443 causal_nueva
              from dual
            union all
            select 327403192 orden, 3443 causal_nueva
              from dual
            union all
            select 324612321 orden, 3443 causal_nueva
              from dual
            union all
            select 327405018 orden, 3443 causal_nueva
              from dual
            union all
            select 326844156 orden, 3443 causal_nueva
              from dual
            union all
            select 327409869 orden, 3443 causal_nueva
              from dual
            union all
            select 326446537 orden, 3443 causal_nueva
              from dual
            union all
            select 327404817 orden, 3443 causal_nueva
              from dual
            union all
            select 327405780 orden, 3443 causal_nueva
              from dual
            union all
            select 327120154 orden, 3443 causal_nueva
              from dual
            union all
            select 327408569 orden, 9777 causal_nueva
              from dual
            union all
            select 327405463 orden, 3443 causal_nueva
              from dual
            union all
            select 326850106 orden, 3443 causal_nueva
              from dual
            union all
            select 327401756 orden, 9777 causal_nueva
              from dual
            union all
            select 326859466 orden, 3443 causal_nueva
              from dual
            union all
            select 327172027 orden, 3443 causal_nueva
              from dual
            union all
            select 326863792 orden, 3443 causal_nueva
              from dual
            union all
            select 327403171 orden, 3443 causal_nueva
              from dual
            union all
            select 326850133 orden, 3443 causal_nueva
              from dual
            union all
            select 327401385 orden, 3443 causal_nueva
              from dual
            union all
            select 327086213 orden, 3443 causal_nueva
              from dual
            union all
            select 326668996 orden, 3443 causal_nueva
              from dual
            union all
            select 327405045 orden, 3443 causal_nueva
              from dual
            union all
            select 327404869 orden, 3443 causal_nueva
              from dual
            union all
            select 327404103 orden, 9777 causal_nueva
              from dual
            union all
            select 326862733 orden, 3443 causal_nueva
              from dual
            union all
            select 327404328 orden, 3443 causal_nueva
              from dual
            union all
            select 327179980 orden, 3443 causal_nueva
              from dual
            union all
            select 327405319 orden, 3443 causal_nueva
              from dual
            union all
            select 327405441 orden, 3443 causal_nueva
              from dual
            union all
            select 327404924 orden, 3443 causal_nueva
              from dual
            union all
            select 327405619 orden, 3443 causal_nueva
              from dual
            union all
            select 327404885 orden, 3443 causal_nueva
              from dual
            union all
            select 327404407 orden, 9777 causal_nueva
              from dual
            union all
            select 327403248 orden, 3443 causal_nueva
              from dual
            union all
            select 327404931 orden, 3443 causal_nueva
              from dual
            union all
            select 327556471 orden, 3443 causal_nueva
              from dual
            union all
            select 327404515 orden, 3443 causal_nueva
              from dual
            union all
            select 327173077 orden, 3443 causal_nueva
              from dual
            union all
            select 327401708 orden, 3443 causal_nueva
              from dual
            union all
            select 327404552 orden, 3443 causal_nueva
              from dual
            union all
            select 326859387 orden, 3443 causal_nueva
              from dual
            union all
            select 326863993 orden, 3443 causal_nueva
              from dual
            union all
            select 327411438 orden, 9777 causal_nueva
              from dual
            union all
            select 327411844 orden, 3443 causal_nueva
              from dual
            union all
            select 327401969 orden, 9777 causal_nueva
              from dual
            union all
            select 327402646 orden, 3443 causal_nueva
              from dual
            union all
            select 327181250 orden, 3443 causal_nueva
              from dual
            union all
            select 327405100 orden, 3443 causal_nueva
              from dual
            union all
            select 327401721 orden, 3443 causal_nueva
              from dual
            union all
            select 327180807 orden, 3443 causal_nueva
              from dual
            union all
            select 327402751 orden, 3443 causal_nueva
              from dual
            union all
            select 327411185 orden, 3443 causal_nueva
              from dual
            union all
            select 327410011 orden, 3443 causal_nueva
              from dual
            union all
            select 327409671 orden, 3443 causal_nueva
              from dual
            union all
            select 326445849 orden, 3443 causal_nueva
              from dual
            union all
            select 327401570 orden, 3443 causal_nueva
              from dual
            union all
            select 327401555 orden, 3443 causal_nueva
              from dual
            union all
            select 327186545 orden, 3443 causal_nueva
              from dual
            union all
            select 326460113 orden, 3443 causal_nueva
              from dual
            union all
            select 326445622 orden, 3443 causal_nueva
              from dual
            union all
            select 327207940 orden, 9777 causal_nueva
              from dual
            union all
            select 327300652 orden, 9777 causal_nueva
              from dual
            union all
            select 326445423 orden, 3443 causal_nueva
              from dual
            union all
            select 327119667 orden, 3443 causal_nueva
              from dual
            union all
            select 326681776 orden, 9777 causal_nueva
              from dual
            union all
            select 327120747 orden, 3443 causal_nueva
              from dual
            union all
            select 327405784 orden, 3443 causal_nueva
              from dual
            union all
            select 327102856 orden, 3443 causal_nueva
              from dual
            union all
            select 327404418 orden, 3443 causal_nueva
              from dual
            union all
            select 326447934 orden, 3443 causal_nueva
              from dual
            union all
            select 327177569 orden, 3443 causal_nueva
              from dual
            union all
            select 327403794 orden, 9777 causal_nueva
              from dual
            union all
            select 327177858 orden, 9777 causal_nueva
              from dual
            union all
            select 327120220 orden, 9777 causal_nueva
              from dual
            union all
            select 326668802 orden, 3443 causal_nueva
              from dual
            union all
            select 326866555 orden, 3443 causal_nueva
              from dual
            union all
            select 326100928 orden, 3443 causal_nueva
              from dual
            union all
            select 327411620 orden, 3443 causal_nueva
              from dual
            union all
            select 326462806 orden, 3443 causal_nueva
              from dual
            union all
            select 327402677 orden, 3443 causal_nueva
              from dual
            union all
            select 327404190 orden, 3443 causal_nueva
              from dual
            union all
            select 327405287 orden, 3443 causal_nueva
              from dual
            union all
            select 326101506 orden, 3443 causal_nueva
              from dual
            union all
            select 327405538 orden, 3443 causal_nueva
              from dual
            union all
            select 327402883 orden, 3443 causal_nueva
              from dual
            union all
            select 327171388 orden, 3443 causal_nueva
              from dual
            union all
            select 327404609 orden, 3443 causal_nueva
              from dual
            union all
            select 327405152 orden, 3443 causal_nueva
              from dual
            union all
            select 326445795 orden, 3443 causal_nueva
              from dual
            union all
            select 327402903 orden, 3443 causal_nueva
              from dual
            union all
            select 326869326 orden, 3443 causal_nueva
              from dual
            union all
            select 327411314 orden, 9777 causal_nueva
              from dual
            union all
            select 327404929 orden, 3443 causal_nueva
              from dual
            union all
            select 327403926 orden, 3443 causal_nueva
              from dual
            union all
            select 327405651 orden, 3443 causal_nueva
              from dual
            union all
            select 327402227 orden, 3443 causal_nueva
              from dual
            union all
            select 327411311 orden, 3443 causal_nueva
              from dual
            union all
            select 326962873 orden, 3443 causal_nueva
              from dual
            union all
            select 327401731 orden, 3443 causal_nueva
              from dual
            union all
            select 327412017 orden, 3443 causal_nueva
              from dual
            union all
            select 326859044 orden, 9777 causal_nueva
              from dual
            union all
            select 327402584 orden, 3443 causal_nueva
              from dual
            union all
            select 326669109 orden, 3443 causal_nueva
              from dual
            union all
            select 327401464 orden, 3443 causal_nueva
              from dual
            union all
            select 327402181 orden, 3443 causal_nueva
              from dual
            union all
            select 327401761 orden, 3443 causal_nueva
              from dual
            union all
            select 326454697 orden, 3443 causal_nueva
              from dual
            union all
            select 326867257 orden, 3443 causal_nueva
              from dual
            union all
            select 326454882 orden, 3443 causal_nueva
              from dual
            union all
            select 327401703 orden, 3443 causal_nueva
              from dual
            union all
            select 327174651 orden, 3443 causal_nueva
              from dual
            union all
            select 327556321 orden, 3443 causal_nueva
              from dual
            union all
            select 327405680 orden, 3443 causal_nueva
              from dual
            union all
            select 326668430 orden, 3443 causal_nueva
              from dual
            union all
            select 327404733 orden, 3443 causal_nueva
              from dual
            union all
            select 327402731 orden, 9777 causal_nueva
              from dual
            union all
            select 326668470 orden, 3443 causal_nueva
              from dual
            union all
            select 326956004 orden, 3443 causal_nueva
              from dual
            union all
            select 327556401 orden, 3443 causal_nueva
              from dual
            union all
            select 327401377 orden, 3443 causal_nueva
              from dual
            union all
            select 327119672 orden, 3443 causal_nueva
              from dual
            union all
            select 327411427 orden, 3443 causal_nueva
              from dual
            union all
            select 327410012 orden, 3443 causal_nueva
              from dual
            union all
            select 324528111 orden, 3443 causal_nueva
              from dual
            union all
            select 327402820 orden, 3443 causal_nueva
              from dual
            union all
            select 327403750 orden, 3443 causal_nueva
              from dual
            union all
            select 327403744 orden, 3443 causal_nueva
              from dual
            union all
            select 326844760 orden, 3443 causal_nueva
              from dual
            union all
            select 327401914 orden, 3443 causal_nueva
              from dual
            union all
            select 327402151 orden, 3443 causal_nueva
              from dual
            union all
            select 327405903 orden, 3443 causal_nueva
              from dual
            union all
            select 327179478 orden, 3443 causal_nueva
              from dual
            union all
            select 327405317 orden, 9777 causal_nueva
              from dual
            union all
            select 327406006 orden, 3443 causal_nueva
              from dual
            union all
            select 327403000 orden, 9777 causal_nueva
              from dual
            union all
            select 327175201 orden, 3443 causal_nueva
              from dual
            union all
            select 327405024 orden, 3443 causal_nueva
              from dual
            union all
            select 327402124 orden, 3443 causal_nueva
              from dual
            union all
            select 327175681 orden, 3443 causal_nueva
              from dual
            union all
            select 326859241 orden, 3443 causal_nueva
              from dual
            union all
            select 327404436 orden, 9777 causal_nueva
              from dual
            union all
            select 327175679 orden, 3443 causal_nueva
              from dual
            union all
            select 327402847 orden, 9777 causal_nueva
              from dual
            union all
            select 327175689 orden, 3443 causal_nueva
              from dual
            union all
            select 327405159 orden, 3443 causal_nueva
              from dual
            union all
            select 327181003 orden, 3443 causal_nueva
              from dual
            union all
            select 327171166 orden, 3443 causal_nueva
              from dual
            union all
            select 327085366 orden, 3443 causal_nueva
              from dual
            union all
            select 327120219 orden, 9777 causal_nueva
              from dual
            union all
            select 326869486 orden, 3443 causal_nueva
              from dual
            union all
            select 327404411 orden, 9777 causal_nueva
              from dual
            union all
            select 326195466 orden, 3443 causal_nueva
              from dual
            union all
            select 326668031 orden, 3443 causal_nueva
              from dual
            union all
            select 327402908 orden, 3443 causal_nueva
              from dual
            union all
            select 326940685 orden, 3443 causal_nueva
              from dual
            union all
            select 327401720 orden, 3443 causal_nueva
              from dual
            union all
            select 327412007 orden, 3443 causal_nueva
              from dual
            union all
            select 327411597 orden, 3443 causal_nueva
              from dual
            union all
            select 327411456 orden, 3443 causal_nueva
              from dual
            union all
            select 327411591 orden, 9777 causal_nueva
              from dual
            union all
            select 327403178 orden, 3443 causal_nueva
              from dual
            union all
            select 327405056 orden, 3443 causal_nueva
              from dual
            union all
            select 327402917 orden, 3443 causal_nueva
              from dual
            union all
            select 327404714 orden, 3443 causal_nueva
              from dual
            union all
            select 326848740 orden, 3443 causal_nueva
              from dual
            union all
            select 327175788 orden, 3443 causal_nueva
              from dual
            union all
            select 326854308 orden, 9777 causal_nueva
              from dual
            union all
            select 327404594 orden, 9777 causal_nueva
              from dual
            union all
            select 326668046 orden, 3443 causal_nueva
              from dual
            union all
            select 327404300 orden, 3443 causal_nueva
              from dual
            union all
            select 326980932 orden, 3443 causal_nueva
              from dual
            union all
            select 327401981 orden, 3443 causal_nueva
              from dual
            union all
            select 327175721 orden, 9777 causal_nueva
              from dual
            union all
            select 327179224 orden, 3443 causal_nueva
              from dual
            union all
            select 327404721 orden, 3443 causal_nueva
              from dual
            union all
            select 327405719 orden, 3443 causal_nueva
              from dual
            union all
            select 326862563 orden, 3443 causal_nueva
              from dual
            union all
            select 326446349 orden, 3443 causal_nueva
              from dual
            union all
            select 327402799 orden, 3443 causal_nueva
              from dual
            union all
            select 327171578 orden, 3443 causal_nueva
              from dual
            union all
            select 327179529 orden, 3443 causal_nueva
              from dual
            union all
            select 326844860 orden, 3443 causal_nueva
              from dual
            union all
            select 327180413 orden, 3443 causal_nueva
              from dual
            union all
            select 327403043 orden, 3443 causal_nueva
              from dual
            union all
            select 327175738 orden, 9777 causal_nueva
              from dual
            union all
            select 327403100 orden, 3443 causal_nueva
              from dual
            union all
            select 326456215 orden, 3443 causal_nueva
              from dual
            union all
            select 327402690 orden, 3443 causal_nueva
              from dual
            union all
            select 327327481 orden, 3443 causal_nueva
              from dual
            union all
            select 326843996 orden, 3443 causal_nueva
              from dual
            union all
            select 327405059 orden, 3443 causal_nueva
              from dual
            union all
            select 327404048 orden, 3443 causal_nueva
              from dual
            union all
            select 327556458 orden, 3443 causal_nueva
              from dual
            union all
            select 327404239 orden, 3443 causal_nueva
              from dual
            union all
            select 327175635 orden, 9777 causal_nueva
              from dual
            union all
            select 327405633 orden, 3443 causal_nueva
              from dual
            union all
            select 327402633 orden, 9777 causal_nueva
              from dual
            union all
            select 327401430 orden, 3443 causal_nueva
              from dual
            union all
            select 327181273 orden, 3443 causal_nueva
              from dual
            union all
            select 326859944 orden, 3443 causal_nueva
              from dual
            union all
            select 327404750 orden, 9777 causal_nueva
              from dual
            union all
            select 327405873 orden, 3443 causal_nueva
              from dual
            union all
            select 327410205 orden, 9777 causal_nueva
              from dual
            union all
            select 327556440 orden, 3443 causal_nueva
              from dual
            union all
            select 327407612 orden, 3443 causal_nueva
              from dual
            union all
            select 327403766 orden, 9777 causal_nueva
              from dual
            union all
            select 327175676 orden, 3443 causal_nueva
              from dual
            union all
            select 327404473 orden, 3443 causal_nueva
              from dual
            union all
            select 327405599 orden, 3443 causal_nueva
              from dual
            union all
            select 326669343 orden, 3443 causal_nueva
              from dual
            union all
            select 327405092 orden, 9777 causal_nueva
              from dual
            union all
            select 326866314 orden, 3443 causal_nueva
              from dual
            union all
            select 327411779 orden, 3443 causal_nueva
              from dual
            union all
            select 327404523 orden, 3443 causal_nueva
              from dual
            union all
            select 327410082 orden, 3443 causal_nueva
              from dual) ordenes
     where ordenes.orden = oo.order_id;

  PROCEDURE pActuCausalOrden(inuOrden          open.or_order.order_id%TYPE,
                             inuCausalNueva    open.or_order.causal_id%TYPE,
                             inuCausalCambiada open.or_order.causal_id%TYPE) IS
    rcOrderComment daor_order_comment.styor_order_comment;
  
    sbComment    or_order_comment.order_comment%TYPE := 'Se actualiza causal ' || inuCausalCambiada || ' con la nueva causal ' || inuCausalNueva || ' - OSF-2860';
    nuCommTypeId or_order_comment.comment_type_id%TYPE := 83;
  
  BEGIN
    
    --/*
    UPDATE or_order
       SET causal_id = inuCausalNueva
     WHERE order_id = inuOrden;
  
    rcOrderComment.order_comment_id := or_bosequences.fnuNextOr_Order_Comment;
    rcOrderComment.order_comment    := sbComment;
    rcOrderComment.order_id         := inuOrden;
    rcOrderComment.comment_type_id  := nuCommTypeId;
    rcOrderComment.register_date    := ut_date.fdtSysdate;
    rcOrderComment.legalize_comment := GE_BOConstants.csbNO;
    rcOrderComment.person_id        := ge_boPersonal.fnuGetPersonId;
  
    daor_order_comment.insRecord(rcOrderComment);
  
    dbms_output.put_line(inuOrden || '|' || inuCausalNueva || '|' ||
                         inuCausalCambiada);
  
    commit;
    --*/
 
  exception
    when others then
      rollback;
      dbms_output.put_line('No se actualiza Orden |' || inuOrden ||
                           '|causal actual|' || inuCausalNueva);
    
  END pActuCausalOrden;

BEGIN

  dbms_output.put_line('ORDEN|CAUSAL NUEVA|CAUSAL CAMBIADA');

  FOR reg IN cuOrdenesNuevaCausal LOOP
    pActuCausalOrden(reg.orden, reg.causal_nueva, reg.causal_legalizada);
  END LOOP;

  commit;

END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/