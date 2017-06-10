DROP PROCEDURE IF EXISTS fashionade_qa.uspFindBestRatedClosetOutfit;
DELIMITER |

CREATE PROCEDURE fashionade_qa.`uspFindBestRatedClosetOutfit`(prmClosetId int)
BEGIN

select co.closetoutfitid
from closetoutfits co
where
	co.closetid=prmClosetId
order by
	co.Rating_EditorRating
limit 1;

END

|