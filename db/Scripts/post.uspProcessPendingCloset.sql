DROP PROCEDURE IF EXISTS uspProcessPendingCloset;

DELIMITER |
CREATE PROCEDURE `uspProcessPendingCloset`(prmClosetId int)
BEGIN


INSERT IGNORE INTO precombinations
(FashionFlavorId, Garment1Id, Garment2Id, Garment3Id, Garment4Id, Garment5Id)
SELECT DISTINCT FashionFlavorId, 
proc.PreGarment1Id, proc.PreGarment2Id, proc.PreGarment3Id, proc.PreGarment4Id, proc.PreGarment5Id
FROM
	proc_closetoutfits proc
WHERE
	closetId = prmClosetId;

INSERT IGNORE INTO closetoutfits
(ClosetId, PreCombinationId, FashionFlavorId, Garment1Id, Garment2Id, Garment3Id, Garment4Id, Garment5Id, Garment6Id,
Garment7Id,Garment8Id,Garment9Id,Garment10Id,Garment11Id, Garment12Id, Garment13Id, EventTypes, Seasons, Status, Visibility, Rating_EditorRating)
SELECT proc.ClosetId, pp.PreCombinationId, proc.FashionFlavorId,
proc.Garment1Id, proc.Garment2Id, proc.Garment3Id, proc.Garment4Id, proc.Garment5Id,
proc.Garment6Id, proc.Garment7Id, proc.Garment8Id, proc.Garment9Id, proc.Garment10Id,
proc.Garment11Id, proc.Garment12Id, proc.Garment13Id,
proc.EventTypes, proc.Seasons, 0, 1, proc.Rating_EditorRating
FROM
	proc_closetoutfits proc
	inner join precombinations pp on
	(pp.FashionFlavorId = proc.FashionFlavorId and
	pp.Garment1Id = proc.PreGarment1Id and
	pp.Garment2Id = proc.PreGarment2Id and
	pp.Garment3Id = proc.PreGarment3Id and
	pp.Garment4Id = proc.PreGarment4Id and
	pp.Garment5Id = proc.PreGarment5Id)
WHERE
	proc.closetId=prmClosetId;
	
delete from proc_closetoutfits where closetId=prmClosetId;
END|
