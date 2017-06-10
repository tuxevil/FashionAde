/* Create procedure to track OutfitUpdaters info */
DROP PROCEDURE IF EXISTS uspInsertTrackingUpdatersInfo;

DELIMITER |
CREATE PROCEDURE uspInsertTrackingUpdatersInfo (IN OutfitUpdaterId INT, IN ClosetOutfitId INT)
BEGIN
  INSERT DELAYED INTO trackingoutfitsupdaters (
      OutfitUpdaterId
    , ClosetOutfitId  
  ) VALUES (     
      OutfitUpdaterId
    , ClosetOutfitId
  );
END|
 