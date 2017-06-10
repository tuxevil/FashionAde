/* Create OutfitUpdaters Tracking table.*/

CREATE TABLE trackingoutfitsupdaters (
   Id INT(11) AUTO_INCREMENT,
   OutfitUpdaterId INT(11),
   ClosetOutfitId INT(11),
  PRIMARY KEY (Id)
) ENGINE = MyISAM ROW_FORMAT = DEFAULT;


