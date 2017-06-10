DROP PROCEDURE IF EXISTS uspUpdateOutfitUpdaterStatusPerSeason;
DELIMITER |
CREATE PROCEDURE `uspUpdateOutfitUpdaterStatusPerSeason`(fromStatus int, toStatus int, currentSeason int)
BEGIN
	update outfitupdaters ou
	set
		ou.Status = toStatus
	where
		ou.Status <= fromStatus and
		ou.Season != currentSeason;
END|
