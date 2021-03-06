﻿/* Create Tracking  Table */

 CREATE TABLE `tracking` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Controller` varchar(100) NOT NULL,
  `Action` varchar(100) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IP` int(10) unsigned DEFAULT NULL,
  `UserId` int(11) DEFAULT NULL,
  `Channel` varchar(50) DEFAULT NULL,
  `AdditionalData` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;


/* Add Channel Column to RegisteredUser */

ALTER TABLE registereduser
 DROP FOREIGN KEY FK34E1D74B3BBCEB6C,
 DROP FOREIGN KEY FK34E1D74B396708F6,
 ADD Channel varchar(50) AFTER NewMail;
ALTER TABLE registereduser
 ADD CONSTRAINT FK34E1D74B3BBCEB6C FOREIGN KEY (SizeId) REFERENCES usersizes (UserSizeId) ON UPDATE RESTRICT ON DELETE RESTRICT,
 ADD CONSTRAINT FK34E1D74B396708F6 FOREIGN KEY (BasicUserId) REFERENCES basicusers (BasicUserId) ON UPDATE RESTRICT ON DELETE RESTRICT;