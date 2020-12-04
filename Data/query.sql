
with query1 as
(select p.NIM ,p.NAMA, pc.rata2 as pasir_cetak,an.rata2 as anodizing,mtl.rata2 as metalografi, lpt.rata2 as LPT, pl.rata2 as `Pengecoran Logam`
,ui.rata2 as `uji impak`,ht.rata2 as `Uji Kekerasan & HT`,ut.rata2 as `uji tarik`, uas.UAS as UAS ,presentasi.NILAI as PRESENTASI, 
(pc.rata2+an.rata2+mtl.rata2+lpt.rata2+pl.rata2+ui.rata2+ht.rata2+ut.rata2)/8 AS nilai_praktikum, 
((UAS*0.35)+(PRESENTASI*0.35)+(((pc.rata2+an.rata2+mtl.rata2+lpt.rata2+pl.rata2+ui.rata2+ht.rata2+ut.rata2)/8)*0.30)) as subtotal
from praktikan as p 
left join (select NIM,(LAPORAN*0.40)+(PENDAHULUAN*0.1)+(JURNAL*0.1)+(PRAKTIKUM*0.4) as rata2 from `pasir cetak`) as pc on p.NIM = pc.NIM
left join (select NIM,(LAPORAN*0.40)+(PENDAHULUAN*0.1)+(JURNAL*0.1)+(PRAKTIKUM*0.4) as rata2 from anodizing) as an on p.NIM=an.NIM
left join (select NIM,(LAPORAN*0.40)+(PENDAHULUAN*0.1)+(JURNAL*0.1)+(PRAKTIKUM*0.4) as rata2 from metalografi) as mtl on p.NIM=mtl.NIM
left join (select NIM,(LAPORAN*0.40)+(PENDAHULUAN*0.1)+(JURNAL*0.1)+(PRAKTIKUM*0.4) as rata2 from lpt) as lpt on p.NIM=lpt.NIM
left join (select NIM,(LAPORAN*0.40)+(PENDAHULUAN*0.1)+(JURNAL*0.1)+(PRAKTIKUM*0.4) as rata2 from `pengecoran logam`) as pl on p.NIM=pl.NIM
left join uas on p.NIM=uas.NIM
left join (select NIM,(LAPORAN*0.40)+(PENDAHULUAN*0.1)+(JURNAL*0.1)+(PRAKTIKUM*0.4) as rata2 from `uji impak`) as ui on p.NIM=ui.NIM
left join (select NIM,(LAPORAN*0.40)+(PENDAHULUAN*0.1)+(JURNAL*0.1)+(PRAKTIKUM*0.4) as rata2 from `uji kekerasan & ht`) as ht on p.NIM=ht.NIM
left join (select NIM,(LAPORAN*0.40)+(PENDAHULUAN*0.1)+(JURNAL*0.1)+(PRAKTIKUM*0.4) as rata2 from `uji tarik`) as ut on p.NIM=ut.NIM
left join presentasi on p.NIM = presentasi.NIM)
select  *,
case 
	WHEN subtotal <=35 then 'E' 
    WHEN subtotal >35 and subtotal <= 49.99 then 'D'
    WHEN subtotal >50 and subtotal <= 64.99 then 'C'
    when subtotal >65 and subtotal <= 79.99 then 'B'
    WHEN subtotal >80 and subtotal <= 100   then 'A'
    else 'K'
    end as Remark
 from query1;
 
 

