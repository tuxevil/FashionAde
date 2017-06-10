DROP PROCEDURE IF EXISTS uspMembershipUsersCount;

DELIMITER |
CREATE PROCEDURE `uspMembershipUsersCount`(IN membershipAppId INT(11))

SELECT COUNT(MB.userId) 
FROM my_aspnet_membership AS MB
 JOIN my_aspnet_users AS MU ON MB.userId = MU.id
WHERE MU.applicationId = membershipAppId;

| 