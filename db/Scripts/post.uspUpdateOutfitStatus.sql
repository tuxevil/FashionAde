DROP PROCEDURE IF EXISTS uspUpdateOutfitStatus;
DELIMITER |
CREATE PROCEDURE `uspUpdateOutfitStatus`(prmClosetId int, prmFromStatus int, prmToStatus int)
BEGIN
	update closetoutfits co
	set
		co.Status = prmToStatus
	where
		co.closetid = prmClosetId and
		co.Status = prmFromStatus;
END|
