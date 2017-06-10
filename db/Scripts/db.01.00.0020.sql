CREATE TABLE `savedfilters` (
  `SavedFilterId` int(11) NOT NULL AUTO_INCREMENT,
  `Search` varchar(200) DEFAULT NULL,
  `Garment` varchar(50) DEFAULT NULL,
  `Trend` varchar(50) DEFAULT NULL,
  `Color` varchar(50) DEFAULT NULL,
  `Pattern` varchar(50) DEFAULT NULL,
  `SeasonName` varchar(50) DEFAULT NULL,
  `CreatedByMe` bit(1) DEFAULT NULL,
  `IsRatedByMe` bit(1) DEFAULT NULL,
  `IsRatedByFriends` bit(1) DEFAULT NULL,
  `SelectedEvents` varchar(50) DEFAULT NULL,
  `SelectedFlavors` varchar(50) DEFAULT NULL,
  `Name` varchar(50) NOT NULL,
  `UserId` int(11) NOT NULL,
  PRIMARY KEY (`SavedFilterId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1; 

ALTER TABLE colors
 DROP FOREIGN KEY colors_ibfk_1,
 ADD ColorCode VARCHAR(7) NOT NULL DEFAULT '#000000' AFTER IsColorful;
ALTER TABLE colors
 ADD CONSTRAINT colors_ibfk_1 FOREIGN KEY (FamilyId) REFERENCES colorfamilies (ColorFamilyId) ON UPDATE RESTRICT ON DELETE RESTRICT;

UPDATE `colors` SET ColorCode = '#3a3a3a' WHERE ColorId = 2;
UPDATE `colors` SET ColorCode = '#767676' WHERE ColorId = 3;
UPDATE `colors` SET ColorCode = '#e9dab1' WHERE ColorId = 4;
UPDATE `colors` SET ColorCode = '#ffffff' WHERE ColorId = 5;
UPDATE `colors` SET ColorCode = '#7b5109' WHERE ColorId = 6;
UPDATE `colors` SET ColorCode = '#77353d' WHERE ColorId = 7;
UPDATE `colors` SET ColorCode = '#c70b22' WHERE ColorId = 8;
UPDATE `colors` SET ColorCode = '#f39898' WHERE ColorId = 9;
UPDATE `colors` SET ColorCode = '#d995b5' WHERE ColorId = 10;
UPDATE `colors` SET ColorCode = '#882345' WHERE ColorId = 11;
UPDATE `colors` SET ColorCode = '#97233f' WHERE ColorId = 12;
UPDATE `colors` SET ColorCode = '#550a48' WHERE ColorId = 13;
UPDATE `colors` SET ColorCode = '#871173' WHERE ColorId = 14;
UPDATE `colors` SET ColorCode = '#c190e6' WHERE ColorId = 15;
UPDATE `colors` SET ColorCode = '#7a83bf' WHERE ColorId = 16;
UPDATE `colors` SET ColorCode = '#55287c' WHERE ColorId = 17;
UPDATE `colors` SET ColorCode = '#300b4f' WHERE ColorId = 18;
UPDATE `colors` SET ColorCode = '#514f6a' WHERE ColorId = 19;
UPDATE `colors` SET ColorCode = '#19269e' WHERE ColorId = 20;
UPDATE `colors` SET ColorCode = '#8dbae6' WHERE ColorId = 21;
UPDATE `colors` SET ColorCode = '#9adcc6' WHERE ColorId = 22;
UPDATE `colors` SET ColorCode = '#00857e' WHERE ColorId = 23;
UPDATE `colors` SET ColorCode = '#106470' WHERE ColorId = 24;
UPDATE `colors` SET ColorCode = '#145814' WHERE ColorId = 25;
UPDATE `colors` SET ColorCode = '#2f8a2f' WHERE ColorId = 26;
UPDATE `colors` SET ColorCode = '#82cc7f' WHERE ColorId = 27;
UPDATE `colors` SET ColorCode = '#72cc19' WHERE ColorId = 28;
UPDATE `colors` SET ColorCode = '#78ab1f' WHERE ColorId = 29;
UPDATE `colors` SET ColorCode = '#55761d' WHERE ColorId = 30;
UPDATE `colors` SET ColorCode = '#dcad09' WHERE ColorId = 31;
UPDATE `colors` SET ColorCode = '#fcdd09' WHERE ColorId = 32;
UPDATE `colors` SET ColorCode = '#e2db0d' WHERE ColorId = 33;
UPDATE `colors` SET ColorCode = '#e5b40b' WHERE ColorId = 34;
UPDATE `colors` SET ColorCode = '#e5a50b' WHERE ColorId = 35;
UPDATE `colors` SET ColorCode = '#e58b0b' WHERE ColorId = 36;
UPDATE `colors` SET ColorCode = '#f46700' WHERE ColorId = 37;
UPDATE `colors` SET ColorCode = '#f48400' WHERE ColorId = 38;
UPDATE `colors` SET ColorCode = '#ff814c' WHERE ColorId = 39;
UPDATE `colors` SET ColorCode = '#ffa57f' WHERE ColorId = 40;
UPDATE `colors` SET ColorCode = '#e9956c' WHERE ColorId = 41;
UPDATE `colors` SET ColorCode = '#f75607' WHERE ColorId = 42;
UPDATE `colors` SET ColorCode = '#838383' WHERE ColorId = 43;
UPDATE `colors` SET ColorCode = '#ad6b4e' WHERE ColorId = 44;
UPDATE `colors` SET ColorCode = '#dcad09' WHERE ColorId = 45;

ALTER TABLE closetoutfits
 CHANGE Status Status INT(3) NOT NULL DEFAULT '0';