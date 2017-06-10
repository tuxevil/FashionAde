DROP PROCEDURE IF EXISTS uspUpdatePrecombinationStatus;
DELIMITER |
CREATE PROCEDURE `uspUpdatePrecombinationStatus`(prmClosetId int, prmStatus int)
BEGIN
	update precombinations p inner join closetoutfits on closetoutfits.precombinationid = p.precombinationid
	set
		p.Status = prmStatus
	where
		closetoutfits.closetid=prmClosetId;
END|
