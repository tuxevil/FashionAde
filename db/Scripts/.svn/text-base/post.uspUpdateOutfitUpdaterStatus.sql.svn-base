DROP PROCEDURE IF EXISTS uspUpdateOutfitUpdaterStatus;
DELIMITER |
CREATE PROCEDURE `uspUpdateOutfitUpdaterStatus`(fromStatus int, toStatus int)
BEGIN
	update outfitupdaters ou
	set
		ou.Status = toStatus
	where
		ou.Status = fromStatus;
END|
