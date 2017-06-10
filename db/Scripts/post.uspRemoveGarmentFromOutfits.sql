DROP PROCEDURE IF EXISTS uspRemoveGarmentFromOutfits;

DELIMITER |
CREATE PROCEDURE `uspRemoveGarmentFromOutfits`(prmClosetId int, prmGarmentId int)
BEGIN

	update closetoutfits 
	set 
		Status = 0
	where 
	closetid=prmClosetId and
	(
	garment1id = prmGarmentId or
	garment2id = prmGarmentId or
	garment3id = prmGarmentId or
	garment4id = prmGarmentId or
	garment5id = prmGarmentId or
	garment6id = prmGarmentId or
	garment7id = prmGarmentId or
	garment8id = prmGarmentId or
	garment9id = prmGarmentId or
	garment10id = prmGarmentId or
	garment11id = prmGarmentId or
	garment12id = prmGarmentId or
	garment13id = prmGarmentId
	);	
		
  update closets c inner join closetoutfits co on co.closetoutfitid = c.FavoriteOutfitId
	set 
		FavoriteOutfitId = NULL
	where
		co.Status = 0;
END|
