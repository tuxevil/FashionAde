truncate table garmentsbyseasons;
truncate table garmentsbyeventtypes;
truncate table garmentsbycolors;
truncate table closetgarments;
truncate table closetoutfits;
truncate table wishgarments;
truncate table usergarment;
truncate table garments;
truncate table silouhettesbycolors;
truncate table silouhettesbycategories;
truncate table silouhettesbycolors;
truncate table silouhettesbyfabrics;
truncate table silouhettesbyflavors;
truncate table silouhettesbypatterns;
truncate table layers;
truncate table silouhettes;
truncate table categories;
truncate table pregarments;
truncate table precombinations;

ALTER TABLE categories AUTO_INCREMENT = 1;
insert into categories (description)
select distinct category2 from mig_silouhettes where category2 != '';

insert into categories (description)
select distinct category from mig_silouhettes where category != '';

update categories c inner join (
select distinct category, category2 from mig_silouhettes where category2 != '') cats
on cats.category2 = c.description
inner join categories parents on parents.description = cats.category
set
	c.ParentId = parents.CategoryId;
	
/**** SILOUHEETES CREATION ***/
ALTER TABLE silouhettes AUTO_INCREMENT = 1;
insert into silouhettes
(ImportanceOrder, ImageUri, Description, ShapeId, StructureId, CategoryId, ExternalCode)
select 1, '', name, s.ShapeId, st.StructureId, c.CategoryId, ms.GarmentId
from 
mig_silouhettes ms
left join shapes s on s.description = ms.shape
left join structures st on st.description = ms. structure
left join categories c on c.description = ms.category2;

insert into silouhettesbycategories
(silouhetteid, categoryid)
select ms.id, c.categoryid
from 
mig_silouhettes ms
left join categories c on c.description = ms.category2;

ALTER TABLE silouhettesbyflavors AUTO_INCREMENT = 1;
insert into silouhettesbyflavors (silouhetteId, flavorId) select ms.id, 1 from mig_silouhettes ms where classic = '1';
insert into silouhettesbyflavors (silouhetteId, flavorId) select ms.id, 2 from mig_silouhettes ms where romantic = '1';
insert into silouhettesbyflavors (silouhetteId, flavorId) select ms.id, 3 from mig_silouhettes ms where comfortable = '1';
insert into silouhettesbyflavors (silouhetteId, flavorId) select ms.id, 4 from mig_silouhettes ms where sporty = '1';
insert into silouhettesbyflavors (silouhetteId, flavorId) select ms.id, 5 from mig_silouhettes ms where preppy = '1';
insert into silouhettesbyflavors (silouhetteId, flavorId) select ms.id, 6 from mig_silouhettes ms where glam = '1';
insert into silouhettesbyflavors (silouhetteId, flavorId) select ms.id, 7 from mig_silouhettes ms where bohemian = '1';
insert into silouhettesbyflavors (silouhetteId, flavorId) select ms.id, 8 from mig_silouhettes ms where trendy = '1';

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
	
ALTER TABLE layers AUTO_INCREMENT = 1;
insert into layers
(layer, silouhette_Id)
select ml.layerId, s.silouhetteId from mig_silouhettes ms 
inner join silouhettes s on s.silouhetteid = ms.id 
inner join migration_layers ml on ml.layerCode = ms.garmentLayer;

ALTER TABLE garments AUTO_INCREMENT = 1;
insert into garments
(silouhetteid, fabricid, patternid, ImageUri, status, linkuri, defaultcolorid)
select s.silouhetteid, fabricid, patternid, '', 1, '', sbc.colorid
from 
	silouhettes s, patterns, fabrics, silouhettesbycolors sbc
where
	sbc.silouhetteid = s.silouhetteid;

ALTER TABLE garmentsbycolors AUTO_INCREMENT = 1;
insert into garmentsbycolors
(garmentid, colorid)
select garmentid, defaultcolorid from garments;

ALTER TABLE garmentsbyeventtypes AUTO_INCREMENT = 1;
insert into garmentsbyeventtypes (garmentid, eventtypeid) select g.garmentid, met.eventtypeid  from mig_events me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 1
inner join migration_eventtypes met on met.eventcode = me.generic;

insert into garmentsbyeventtypes (garmentid, eventtypeid) select g.garmentid, met.eventtypeid  from mig_events me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 2
inner join migration_eventtypes met on met.eventcode = me.satin;

insert into garmentsbyeventtypes (garmentid, eventtypeid) select g.garmentid, met.eventtypeid  from mig_events me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 3
inner join migration_eventtypes met on met.eventcode = me.lace;

insert into garmentsbyeventtypes (garmentid, eventtypeid) select g.garmentid, met.eventtypeid  from mig_events me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 4
inner join migration_eventtypes met on met.eventcode = me.sequin;

insert into garmentsbyeventtypes (garmentid, eventtypeid) select g.garmentid, met.eventtypeid  from mig_events me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 5
inner join migration_eventtypes met on met.eventcode = me.brocade;

insert into garmentsbyeventtypes (garmentid, eventtypeid) select g.garmentid, met.eventtypeid  from mig_events me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 6
inner join migration_eventtypes met on met.eventcode = me.denim;

insert into garmentsbyeventtypes (garmentid, eventtypeid) select g.garmentid, met.eventtypeid  from mig_events me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 7
inner join migration_eventtypes met on met.eventcode = me.leather;

insert into garmentsbyeventtypes (garmentid, eventtypeid) select g.garmentid, met.eventtypeid  from mig_events me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 8
inner join migration_eventtypes met on met.eventcode = me.suede;

insert into garmentsbyeventtypes (garmentid, eventtypeid) select g.garmentid, met.eventtypeid  from mig_events me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 9
inner join migration_eventtypes met on met.eventcode = me.boucle;

insert into garmentsbyeventtypes (garmentid, eventtypeid) select g.garmentid, met.eventtypeid  from mig_events me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 10
inner join migration_eventtypes met on met.eventcode = me.corduroy;

insert into garmentsbyeventtypes (garmentid, eventtypeid) select g.garmentid, met.eventtypeid  from mig_events me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 11
inner join migration_eventtypes met on met.eventcode = me.velvet;

insert into garmentsbyeventtypes (garmentid, eventtypeid) select g.garmentid, met.eventtypeid  from mig_events me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 12
inner join migration_eventtypes met on met.eventcode = me.velour;

insert into garmentsbyeventtypes (garmentid, eventtypeid) select g.garmentid, met.eventtypeid  from mig_events me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 13
inner join migration_eventtypes met on met.eventcode = me.fleece;

insert into garmentsbyeventtypes (garmentid, eventtypeid) select g.garmentid, met.eventtypeid  from mig_events me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 14
inner join migration_eventtypes met on met.eventcode = me.knit;

insert into garmentsbyeventtypes (garmentid, eventtypeid) select g.garmentid, met.eventtypeid  from mig_events me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 15
inner join migration_eventtypes met on met.eventcode = me.fur;

insert into garmentsbyeventtypes (garmentid, eventtypeid) select g.garmentid, met.eventtypeid  from mig_events me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 16
inner join migration_eventtypes met on met.eventcode = me.metallic;

insert into garmentsbyeventtypes (garmentid, eventtypeid) select g.garmentid, met.eventtypeid  from mig_events me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 17
inner join migration_eventtypes met on met.eventcode = me.cotton;

insert into garmentsbyeventtypes (garmentid, eventtypeid) select g.garmentid, met.eventtypeid  from mig_events me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 18
inner join migration_eventtypes met on met.eventcode = me.linen;

insert into garmentsbyeventtypes (garmentid, eventtypeid) select g.garmentid, met.eventtypeid  from mig_events me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 19
inner join migration_eventtypes met on met.eventcode = me.wool;

insert into garmentsbyeventtypes (garmentid, eventtypeid) select g.garmentid, met.eventtypeid  from mig_events me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 20
inner join migration_eventtypes met on met.eventcode = me.twill;

insert into garmentsbyeventtypes (garmentid, eventtypeid) select g.garmentid, met.eventtypeid  from mig_events me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 21
inner join migration_eventtypes met on met.eventcode = me.jersey;

insert into garmentsbyeventtypes (garmentid, eventtypeid) select g.garmentid, met.eventtypeid  from mig_events me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 22
inner join migration_eventtypes met on met.eventcode = me.silk;

insert into garmentsbyeventtypes (garmentid, eventtypeid) select g.garmentid, met.eventtypeid  from mig_events me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 23
inner join migration_eventtypes met on met.eventcode = me.sweatshirt;

insert into garmentsbyeventtypes (garmentid, eventtypeid) select g.garmentid, met.eventtypeid  from mig_events me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 24
inner join migration_eventtypes met on met.eventcode = me.patent;

insert into garmentsbyeventtypes (garmentid, eventtypeid) select g.garmentid, met.eventtypeid  from mig_events me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 25
inner join migration_eventtypes met on met.eventcode = me.rubber;

insert into garmentsbyeventtypes (garmentid, eventtypeid) select g.garmentid, met.eventtypeid  from mig_events me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 26
inner join migration_eventtypes met on met.eventcode = me.elastic;

ALTER TABLE garmentsbyseasons AUTO_INCREMENT = 1;

insert into garmentsbyseasons (GarmentTags_id, season) select g.garmentid, met.seasonid  from mig_seasons me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 1
inner join migration_seasonmatch met on met.seasoncode = me.generic;

insert into garmentsbyseasons (GarmentTags_id, season) select g.garmentid, met.seasonid  from mig_seasons me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 2
inner join migration_seasonmatch met on met.seasoncode = me.satin;

insert into garmentsbyseasons (GarmentTags_id, season) select g.garmentid, met.seasonid  from mig_seasons me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 3
inner join migration_seasonmatch met on met.seasoncode = me.lace;

insert into garmentsbyseasons (GarmentTags_id, season) select g.garmentid, met.seasonid  from mig_seasons me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 4
inner join migration_seasonmatch met on met.seasoncode = me.sequin;

insert into garmentsbyseasons (GarmentTags_id, season) select g.garmentid, met.seasonid  from mig_seasons me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 5
inner join migration_seasonmatch met on met.seasoncode = me.brocade;

insert into garmentsbyseasons (GarmentTags_id, season) select g.garmentid, met.seasonid  from mig_seasons me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 6
inner join migration_seasonmatch met on met.seasoncode = me.denim;

insert into garmentsbyseasons (GarmentTags_id, season) select g.garmentid, met.seasonid  from mig_seasons me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 7
inner join migration_seasonmatch met on met.seasoncode = me.leather;

insert into garmentsbyseasons (GarmentTags_id, season) select g.garmentid, met.seasonid  from mig_seasons me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 8
inner join migration_seasonmatch met on met.seasoncode = me.suede;

insert into garmentsbyseasons (GarmentTags_id, season) select g.garmentid, met.seasonid  from mig_seasons me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 9
inner join migration_seasonmatch met on met.seasoncode = me.boucle;

insert into garmentsbyseasons (GarmentTags_id, season) select g.garmentid, met.seasonid  from mig_seasons me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 10
inner join migration_seasonmatch met on met.seasoncode = me.corduroy;

insert into garmentsbyseasons (GarmentTags_id, season) select g.garmentid, met.seasonid  from mig_seasons me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 11
inner join migration_seasonmatch met on met.seasoncode = me.velvet;

insert into garmentsbyseasons (GarmentTags_id, season) select g.garmentid, met.seasonid  from mig_seasons me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 12
inner join migration_seasonmatch met on met.seasoncode = me.velour;

insert into garmentsbyseasons (GarmentTags_id, season) select g.garmentid, met.seasonid  from mig_seasons me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 13
inner join migration_seasonmatch met on met.seasoncode = me.fleece;

insert into garmentsbyseasons (GarmentTags_id, season) select g.garmentid, met.seasonid  from mig_seasons me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 14
inner join migration_seasonmatch met on met.seasoncode = me.knit;

insert into garmentsbyseasons (GarmentTags_id, season) select g.garmentid, met.seasonid  from mig_seasons me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 15
inner join migration_seasonmatch met on met.seasoncode = me.fur;

insert into garmentsbyseasons (GarmentTags_id, season) select g.garmentid, met.seasonid  from mig_seasons me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 16
inner join migration_seasonmatch met on met.seasoncode = me.metallic;

insert into garmentsbyseasons (GarmentTags_id, season) select g.garmentid, met.seasonid  from mig_seasons me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 17
inner join migration_seasonmatch met on met.seasoncode = me.cotton;

insert into garmentsbyseasons (GarmentTags_id, season) select g.garmentid, met.seasonid  from mig_seasons me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 18
inner join migration_seasonmatch met on met.seasoncode = me.linen;

insert into garmentsbyseasons (GarmentTags_id, season) select g.garmentid, met.seasonid  from mig_seasons me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 19
inner join migration_seasonmatch met on met.seasoncode = me.wool;

insert into garmentsbyseasons (GarmentTags_id, season) select g.garmentid, met.seasonid  from mig_seasons me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 20
inner join migration_seasonmatch met on met.seasoncode = me.twill;

insert into garmentsbyseasons (GarmentTags_id, season) select g.garmentid, met.seasonid  from mig_seasons me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 21
inner join migration_seasonmatch met on met.seasoncode = me.jersey;

insert into garmentsbyseasons (GarmentTags_id, season) select g.garmentid, met.seasonid  from mig_seasons me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 22
inner join migration_seasonmatch met on met.seasoncode = me.silk;

insert into garmentsbyseasons (GarmentTags_id, season) select g.garmentid, met.seasonid  from mig_seasons me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 23
inner join migration_seasonmatch met on met.seasoncode = me.sweatshirt;

insert into garmentsbyseasons (GarmentTags_id, season) select g.garmentid, met.seasonid  from mig_seasons me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 24
inner join migration_seasonmatch met on met.seasoncode = me.patent;

insert into garmentsbyseasons (GarmentTags_id, season) select g.garmentid, met.seasonid  from mig_seasons me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 25
inner join migration_seasonmatch met on met.seasoncode = me.rubber;

insert into garmentsbyseasons (GarmentTags_id, season) select g.garmentid, met.seasonid  from mig_seasons me
inner join garments g on g.silouhetteid = me.id and g.fabricid = 26
inner join migration_seasonmatch met on met.seasoncode = me.elastic;

-- Remove all garments not needed because they dont have a event type/season defined for the fabric.
delete from garmentsbycolors
where garmentid not in (select distinct GarmentId from garmentsbyeventtypes);

delete from garmentsbyseasons
where GarmentTags_id not in (select distinct GarmentId from garmentsbyeventtypes);

delete from garments
where garmentid not in (select distinct GarmentId from garmentsbyeventtypes);

delete from silouhettesbycategories
where silouhetteid not in (select distinct silouhetteid from garments);

delete from silouhettesbycolors
where silouhetteid not in (select distinct silouhetteid from garments);

delete from silouhettesbyflavors
where silouhetteid not in (select distinct silouhetteid from garments);

delete from layers
where silouhette_id not in (select distinct silouhetteid from garments);

delete from silouhettes
where silouhetteid not in (select distinct silouhetteid from garments);

-- Set silouhettes defaults on colors, patterns and fabrics
insert into silouhettesbyfabrics
select distinct SilouhetteId, fabricid from garments;

insert into silouhettesbypatterns
select distinct SilouhetteId, patternid from garments;

-- Relate to garment images.
update garments g 
inner join silouhettes s on s.silouhetteid = g.silouhetteid
inner join silouhettesbycategories sbc on sbc.silouhetteid = g.silouhetteid
inner join categories cat on cat.categoryid = sbc.categoryid
inner join patterns pt on pt.patternid = g.patternid
inner join colors c on c.colorid = g.defaultcolorid
set 
	g.title = CONCAT(s.description, ' ', c.description, ' ', cat.description),
	g.imageuri = CONCAT(s.externalcode, 'C', g.defaultcolorid, pt.code, '.png');

update silouhettes set imageuri = CONCAT(externalcode, '.png');

# Create binary for Outfit Engine
update garments g, (select gbe.garmentid, sum(BinaryNumber) as sumbinary from garmentsbyeventtypes gbe inner join eventtypes ON gbe.EventTypeId = eventtypes.EventTypeId
group by
	gbe.GarmentId
)	tmp
set
	g.EventCode = tmp.sumbinary
where
	tmp.garmentid = g.GarmentId;
	
update garments g, (select gbs.GarmentTags_id as GarmentId, sum(BinaryNumber) as sumbinary from garmentsbyseasons gbs inner join seasons ON gbs.Season = seasons.Season
group by
	gbs.GarmentTags_id
)	tmp
set
	g.SeasonCode = tmp.sumbinary
where
	tmp.garmentid = g.GarmentId;	

# Create pregarments, presilouhettes and so on and any other extra table needed.
truncate table pregarments;

insert into pregarments
(silouhetteid, colorfamilyid, patterntype)
select silouhetteid, colorfamilyid, 1  from silouhettes, colorfamilies;
	
insert into pregarments
(silouhetteid, colorfamilyid, patterntype)
select silouhetteid, colorfamilyid, 2  from silouhettes, colorfamilies;

insert into pregarments
(silouhetteid, colorfamilyid, patterntype)
select silouhetteid, colorfamilyid, 3  from silouhettes, colorfamilies;

update garments as g
inner join garmentsbycolors gbc on gbc.garmentid = g.garmentid
inner join colors c on c.colorid = gbc.colorid
inner join patterns p on p.patternid = g.patternid
inner join pregarments pg on pg.silouhetteid = g.silouhetteid and pg.colorfamilyid = c.familyid and pg.patterntype = p.type
set
	g.pregarmentid = pg.pregarmentid;
	
-- add accessories and set categories to original
truncate table silouhettefabricsbyeventtypes;
insert into silouhettefabricsbyeventtypes
select distinct g.silouhetteid, g.fabricid, gbe.eventtypeid from garments g
inner join garmentsbyeventtypes gbe on gbe.garmentid = g.garmentid;

truncate table silouhettefabricsbyseasons;
insert into silouhettefabricsbyseasons
select distinct g.silouhetteid, g.fabricid, gbe.season from garments g
inner join garmentsbyseasons gbe on gbe.GarmentTags_id = g.garmentid;

/*
insert into `stylerulesaccessories`(`StyleRuleId`,`Amount`) values (1,3);
insert into `stylerulesaccessories`(`StyleRuleId`,`Amount`) values (2,4);
insert into `stylerulesaccessories`(`StyleRuleId`,`Amount`) values (3,3);
insert into `stylerulesaccessories`(`StyleRuleId`,`Amount`) values (4,3);
insert into `stylerulesaccessories`(`StyleRuleId`,`Amount`) values (5,3);
insert into `stylerulesaccessories`(`StyleRuleId`,`Amount`) values (6,3);
insert into `stylerulesaccessories`(`StyleRuleId`,`Amount`) values (7,4);
insert into `stylerulesaccessories`(`StyleRuleId`,`Amount`) values (8,4);
insert into `stylerulesaccessories`(`StyleRuleId`,`Amount`) values (3,1);
insert into `stylerulesaccessories`(`StyleRuleId`,`Amount`) values (4,1);
insert into `stylerulesaccessories`(`StyleRuleId`,`Amount`) values (5,1);
insert into `stylerulesaccessories`(`StyleRuleId`,`Amount`) values (6,5);
*/

/*
truncate table stylerulespatterns;
truncate table stylerulesstructures;
truncate table stylerulesshapes;
truncate table stylerulesaccessories;
truncate table stylerules;

truncate table shapes;

insert into `shapes`(`Description`,`Type`) values ('Fitted 100',11);
insert into `shapes`(`Description`,`Type`) values ('Fitted 200',12);
insert into `shapes`(`Description`,`Type`) values ('Fitted 300',13);
insert into `shapes`(`Description`,`Type`) values ('Fitted 400',14);
insert into `shapes`(`Description`,`Type`) values ('Fitted 500',15);
insert into `shapes`(`Description`,`Type`) values ('Fitted 600',16);
insert into `shapes`(`Description`,`Type`) values ('Fitted 700',16);
insert into `shapes`(`Description`,`Type`) values ('Fitted 800',16);
insert into `shapes`(`Description`,`Type`) values ('Fitted 900',16);

insert into `shapes`(`Description`,`Type`) values ('Slim 100',1);
insert into `shapes`(`Description`,`Type`) values ('Slim 200',2);
insert into `shapes`(`Description`,`Type`) values ('Slim 300',3);
insert into `shapes`(`Description`,`Type`) values ('Slim 400',4);
insert into `shapes`(`Description`,`Type`) values ('Slim 500',5);
insert into `shapes`(`Description`,`Type`) values ('Slim 600',6);
insert into `shapes`(`Description`,`Type`) values ('Slim 700',6);
insert into `shapes`(`Description`,`Type`) values ('Slim 800',6);
insert into `shapes`(`Description`,`Type`) values ('Slim 900',6);

insert into `shapes`(`Description`,`Type`) values ('Loose 100',21);
insert into `shapes`(`Description`,`Type`) values ('Loose 200',22);
insert into `shapes`(`Description`,`Type`) values ('Loose 300',23);
insert into `shapes`(`Description`,`Type`) values ('Loose 400',24);
insert into `shapes`(`Description`,`Type`) values ('Loose 500',25);
insert into `shapes`(`Description`,`Type`) values ('Loose 600',26);
insert into `shapes`(`Description`,`Type`) values ('Loose 700',26);
insert into `shapes`(`Description`,`Type`) values ('Loose 800',26);
insert into `shapes`(`Description`,`Type`) values ('Loose 900',26);
*/

select * from stylerulesaccessories;