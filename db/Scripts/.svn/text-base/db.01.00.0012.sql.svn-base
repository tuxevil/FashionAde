ALTER TABLE garments
 DROP FOREIGN KEY garments_ibfk_1,
 DROP FOREIGN KEY garments_ibfk_2,
 DROP FOREIGN KEY garments_ibfk_3,
 DROP FOREIGN KEY garments_ibfk_5,
 ADD Keywords VARCHAR(100) AFTER Type;

ALTER TABLE garments
 ADD CONSTRAINT garments_ibfk_1 FOREIGN KEY (SilouhetteId) REFERENCES silouhettes (SilouhetteId) ON UPDATE RESTRICT ON DELETE RESTRICT,
 ADD CONSTRAINT garments_ibfk_2 FOREIGN KEY (PatternId) REFERENCES patterns (PatternId) ON UPDATE RESTRICT ON DELETE RESTRICT,
 ADD CONSTRAINT garments_ibfk_3 FOREIGN KEY (FabricId) REFERENCES fabrics (FabricId) ON UPDATE RESTRICT ON DELETE RESTRICT,
 ADD CONSTRAINT garments_ibfk_4 FOREIGN KEY (PreGarmentId) REFERENCES pregarments (pregarmentid) ON UPDATE RESTRICT ON DELETE RESTRICT,
 ADD CONSTRAINT garments_ibfk_5 FOREIGN KEY (DefaultColorId) REFERENCES colors (ColorId) ON UPDATE RESTRICT ON DELETE RESTRICT;
 
update garments g 
inner join silouhettes s on s.silouhetteid = g.silouhetteid
inner join silouhettesbycategories sbc on sbc.silouhetteid = g.silouhetteid
inner join categories cat on cat.categoryid = sbc.categoryid
inner join patterns pt on pt.patternid = g.patternid
inner join fabrics fb on fb.fabricid = g.fabricid
inner join colors c on c.colorid = g.defaultcolorid
set 
	g.title = CONCAT(s.description, ' ', c.description),
	g.keywords = CONCAT(cat.description, ' ', pt.description, ' ', fb.description);
