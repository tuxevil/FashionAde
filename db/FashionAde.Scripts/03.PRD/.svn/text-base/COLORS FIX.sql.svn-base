
truncate table silouhettesbycolors;

insert into silouhettesbycolors
select silouhetteid, colorid from
silouhettes s, colors c
where
	c.colorid in (1,5,19,20,21) and
	s.ExternalCode in (
'200101',
'200102',
'200103',
'200104',
'200106',
'200107',
'200108',
'200109',
'200110',
'200111'
);

insert into silouhettesbycolors
select silouhetteid, colorid from
silouhettes s, colors c
where
	s.ExternalCode in (
'222106',
'222107',
'333102',
'333104',
'444101',
'555101',
'555102',
'555109'
);

insert into silouhettesbycolors
select silouhetteid, colorid from
silouhettes s, colors c
where
	c.colorid in (43,44,45) and
	s.ExternalCode in (
'222101',
'222103',
'222104',
'222105',
'222112',
'222113',
'333101',
'333103',
'333105',
'444102',
'555103',
'555104',
'555105',
'555106',
'666106'
);

insert into silouhettesbycolors
select silouhetteid, colorid from
silouhettes s, colors c
where
	c.colorid in (5) and
	s.ExternalCode in (
'222108',
'222109',
'222110',
'222111'
);

insert into silouhettesbycolors
select silouhetteid, colorid from
silouhettes s, colors c
where
	c.colorid >= 1 and c.colorid <= 42 and
	s.silouhetteid not in (select distinct silouhetteid from silouhettesbycolors);