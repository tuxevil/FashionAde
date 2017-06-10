/*TRUNCATE TABLE outfitupdaterbyprecombinations;
TRUNCATE TABLE outfitupdatersbytrend;
TRUNCATE TABLE outfitupdaters;*/

ALTER TABLE outfitupdaterbyprecombinations
 DROP FOREIGN KEY PreCombinations,
 DROP FOREIGN KEY OutfitUpdaters;

ALTER TABLE outfitupdaterbyprecombinations
 ADD CONSTRAINT PreCombinations FOREIGN KEY (PreCombinationId) REFERENCES precombinations (PreCombinationId) ON UPDATE RESTRICT ON DELETE RESTRICT,
 ADD CONSTRAINT OutfitUpdaters FOREIGN KEY (OutfitUpdaterId) REFERENCES outfitupdaters (OutfitUpdaterId) ON UPDATE RESTRICT ON DELETE RESTRICT,
  ADD PRIMARY KEY (OutfitUpdaterId, PreCombinationId);
 