DROP PROCEDURE IF EXISTS uspMigrateInvitedUser;

DELIMITER |
CREATE PROCEDURE uspMigrateInvitedUser(invitedUserId int, registeredUserId int)
BEGIN
	update friends
	set 
		UserId = registeredUserId,
		Status = 1
	where
		UserId = invitedUserId;

	update friendratings
	set 
		FriendId = registeredUserId
	where
		FriendId = invitedUserId;

	delete from inviteduser where BasicUserId = invitedUserId;
	delete from basicusers where BasicUserId = invitedUserId;
END|
