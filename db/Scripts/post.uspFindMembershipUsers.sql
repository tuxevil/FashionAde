DROP PROCEDURE IF EXISTS uspFindMembershipUsers;

DELIMITER |
CREATE PROCEDURE `uspFindMembershipUsers`(IN searchText varchar(256), IN  isLockedOut TINYINT(1),IN  isApproved  TINYINT(1), IN applicationId INT(11))

SELECT      
      MU.id     
  FROM my_aspnet_membership AS MB
  INNER JOIN my_aspnet_users AS MU on MB.userId = MU.id
  WHERE
    MU.applicationId = applicationId
    AND (MU.name LIKE CONCAT(LOWER(TRIM(searchText)),'%') OR MB.Email LIKE CONCAT(LOWER(TRIM(searchText)),'%'))
    AND MB.IsLockedOut = isLockedOut
    AND MB.IsApproved = isApproved
  ORDER BY MB.CreationDate DESC;

|