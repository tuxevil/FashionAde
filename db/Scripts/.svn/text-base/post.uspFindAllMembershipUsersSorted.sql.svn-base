DROP PROCEDURE IF EXISTS uspFindAllMembershipUsersSorted;

DELIMITER |
CREATE PROCEDURE `uspFindAllMembershipUsersSorted`(IN membershipAppId INT(11))

SELECT 
    MB.userId
  , MU.name
  , Mb.Email
  , MB.Comment
  , MB.PasswordQuestion  
  , MB.IsApproved  
  , MB.LastActivityDate
  , MB.LastLoginDate
  , MB.LastPasswordChangedDate
  , MB.CreationDate
  , MB.IsLockedOut
  , MB.LastLockedOutDate
FROM my_aspnet_membership AS MB
  INNER JOIN my_aspnet_users AS MU  ON MB.userId = MU.id
WHERE MU.ApplicationId = membershipAppId
ORDER BY MB.CreationDate DESC;

| 