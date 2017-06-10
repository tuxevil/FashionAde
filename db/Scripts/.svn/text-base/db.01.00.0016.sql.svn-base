
ALTER TABLE fashionade_beta.invitationcodes
 DROP FOREIGN KEY invitationcodes_ibfk_1,
 ADD CreatedOn TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL AFTER IsUsed;
ALTER TABLE fashionade_beta.invitationcodes
 ADD CONSTRAINT invitationcodes_ibfk_1 FOREIGN KEY (InvitedById) REFERENCES fashionade_beta.basicusers (BasicUserId) ON UPDATE RESTRICT ON DELETE RESTRICT;
