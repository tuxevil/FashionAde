
      /*
      * Script created by Quest Schema Compare at 10/13/2010 4:56:26 PM.
      * Please back up your database before running this script.
      *
      * Synchronizing objects from fashionade_qa to fashionade_beta.
      */
    USE `fashionade_beta`;

-- Drop foreign keys, referenced to outfitupdaters
ALTER TABLE `fashionade_beta`.`outfitupdaterbyprecombinations` DROP FOREIGN KEY `OutfitUpdaters`;

-- Drop foreign keys, referenced to outfitupdaters
ALTER TABLE `fashionade_beta`.`outfitupdatersbytrend` DROP FOREIGN KEY `outfitupdater`;

-- Drop foreign keys, referenced to trends
ALTER TABLE `fashionade_beta`.`outfitupdatersbytrend` DROP FOREIGN KEY `trend`;

-- Drop foreign keys, referenced to trends
ALTER TABLE `fashionade_beta`.`trendkeywords` DROP FOREIGN KEY `trends`;

ALTER TABLE `fashionade_beta`.`outfitupdaters` DROP FOREIGN KEY `colorfamily`;

ALTER TABLE `fashionade_beta`.`outfitupdaters` DROP FOREIGN KEY `partner`;

ALTER TABLE `fashionade_beta`.`outfitupdaters` DROP FOREIGN KEY `patterns`;

ALTER TABLE `fashionade_beta`.`outfitupdaters` DROP FOREIGN KEY `silouhettes`;

/* Header line. Object: outfitupdaters. Script date: 10/13/2010 4:56:26 PM. */
DROP TABLE IF EXISTS `fashionade_beta`.`_temp_outfitupdaters`;

CREATE TABLE `fashionade_beta`.`_temp_outfitupdaters` (
	`OutfitUpdaterId` int(11) NOT NULL,
	`Name` varchar(500) NOT NULL,
	`Description` varchar(10000) NOT NULL,
	`Keywords` varchar(10000) NOT NULL,
	`ExternalId` varchar(100) NOT NULL,
	`Price` double NOT NULL,
	`BuyUrl` varchar(500) NOT NULL,
	`ImageUrl` varchar(500) NOT NULL,
	`PartnerId` int(11) NOT NULL,
	`SilouhetteId` int(11) default NULL,
	`PatternId` int(11) default NULL,
	`ColorFamilyId` int(11) default NULL,
	`Status` int(11) NOT NULL,
	`CreatedOn` timestamp NOT NULL,
	`Season` int(11) NOT NULL default '2',
	KEY `colorfamily` ( `ColorFamilyId` ),
	UNIQUE INDEX `ExternalId` ( `ExternalId`, `PartnerId` ),
	KEY `partner` ( `PartnerId` ),
	KEY `patterns` ( `PatternId` ),
	PRIMARY KEY  ( `OutfitUpdaterId` ),
	KEY `silouhettes` ( `SilouhetteId` )
)
ENGINE = InnoDB
CHARACTER SET = latin1
ROW_FORMAT = Compact
;

INSERT INTO `fashionade_beta`.`_temp_outfitupdaters`
( `BuyUrl`, `ColorFamilyId`, `CreatedOn`, `Description`, `ExternalId`, `ImageUrl`, `Keywords`, `Name`, `OutfitUpdaterId`, `PartnerId`, `PatternId`, `Price`, `SilouhetteId`, `Status` )
SELECT
`BuyUrl`, `ColorFamilyId`, `CreatedOn`, `Description`, `ExternalId`, `ImageUrl`, `Keywords`, `Name`, `OutfitUpdaterId`, `PartnerId`, `PatternId`, `Price`, `SilouhetteId`, `Status`
FROM `fashionade_beta`.`outfitupdaters`;

DROP TABLE `fashionade_beta`.`outfitupdaters`;

ALTER TABLE `fashionade_beta`.`_temp_outfitupdaters` RENAME `outfitupdaters`;

/* Header line. Object: seasons. Script date: 10/13/2010 4:56:26 PM. */
DROP TABLE IF EXISTS `fashionade_beta`.`_temp_seasons`;

CREATE TABLE `fashionade_beta`.`_temp_seasons` (
	`Season` int(11) default NULL,
	`BinaryNumber` int(11) default NULL,
	`Name` varchar(20) default NULL
)
ENGINE = InnoDB
CHARACTER SET = latin1
ROW_FORMAT = Compact
;

INSERT INTO `fashionade_beta`.`_temp_seasons`
( `BinaryNumber`, `Season` )
SELECT
`BinaryNumber`, `Season`
FROM `fashionade_beta`.`seasons`;

DROP TABLE `fashionade_beta`.`seasons`;

ALTER TABLE `fashionade_beta`.`_temp_seasons` RENAME `seasons`;

/* Header line. Object: trends. Script date: 10/13/2010 4:56:26 PM. */
DROP TABLE IF EXISTS `fashionade_beta`.`_temp_trends`;

CREATE TABLE `fashionade_beta`.`_temp_trends` (
	`trendid` int(11) NOT NULL auto_increment,
	`name` varchar(50) NOT NULL,
	`Season` int(11) default '2',
	`IsEnabled` tinyint(4) default '1',
	PRIMARY KEY  ( `trendid` )
)
ENGINE = InnoDB
CHARACTER SET = latin1
AUTO_INCREMENT = 22
ROW_FORMAT = Compact
;

INSERT INTO `fashionade_beta`.`_temp_trends`
( `name`, `trendid` )
SELECT
`name`, `trendid`
FROM `fashionade_beta`.`trends`;

DROP TABLE `fashionade_beta`.`trends`;

ALTER TABLE `fashionade_beta`.`_temp_trends` RENAME `trends`;

/* Header line. Object: trendsbyflavors. Script date: 10/13/2010 4:56:26 PM. */
CREATE TABLE `fashionade_beta`.`trendsbyflavors` (
	`TrendId` int(11) NOT NULL default '0',
	`FashionFlavorId` int(11) NOT NULL default '0',
	PRIMARY KEY  ( `TrendId`, `FashionFlavorId` )
)
ENGINE = InnoDB
CHARACTER SET = latin1
ROW_FORMAT = Compact
;

/* Header line. Object: uspUpdateOutfitUpdaterStatus. Script date: 10/13/2010 4:56:26 PM. */
CREATE DEFINER=`root`@`%` PROCEDURE `uspUpdateOutfitUpdaterStatus`(fromStatus int, toStatus int)
BEGIN
	update outfitupdaters ou
	set
		ou.Status = toStatus
	where
		ou.Status = fromStatus;
END;

/* Header line. Object: uspUpdateOutfitUpdaterStatusPerSeason. Script date: 10/13/2010 4:56:26 PM. */
CREATE DEFINER=`root`@`%` PROCEDURE `uspUpdateOutfitUpdaterStatusPerSeason`(fromStatus int, toStatus int, currentSeason int)
BEGIN
	update outfitupdaters ou
	set
		ou.Status = toStatus
	where
		ou.Status <= fromStatus and
		ou.Season != currentSeason;
END;

-- Restore foreign keys, referenced to outfitupdaters
ALTER TABLE `fashionade_beta`.`outfitupdaterbyprecombinations` ADD CONSTRAINT `OutfitUpdaters`
	FOREIGN KEY ( `OutfitUpdaterId` ) REFERENCES `outfitupdaters` ( `OutfitUpdaterId` );

-- Restore foreign keys, referenced to outfitupdaters
ALTER TABLE `fashionade_beta`.`outfitupdatersbytrend` ADD CONSTRAINT `outfitupdater`
	FOREIGN KEY ( `OutfitUpdaterId` ) REFERENCES `outfitupdaters` ( `OutfitUpdaterId` );

-- Restore foreign keys, referenced to trends
ALTER TABLE `fashionade_beta`.`outfitupdatersbytrend` ADD CONSTRAINT `trend`
	FOREIGN KEY ( `TrendId` ) REFERENCES `trends` ( `trendid` );

-- Restore foreign keys, referenced to trends
ALTER TABLE `fashionade_beta`.`trendkeywords` ADD CONSTRAINT `trends`
	FOREIGN KEY ( `trendid` ) REFERENCES `trends` ( `trendid` );

-- Update foreign keys of outfitupdaters
ALTER TABLE `fashionade_beta`.`outfitupdaters` ADD CONSTRAINT `colorfamily`
	FOREIGN KEY ( `ColorFamilyId` ) REFERENCES `colorfamilies` ( `ColorFamilyId` );

ALTER TABLE `fashionade_beta`.`outfitupdaters` ADD CONSTRAINT `partner`
	FOREIGN KEY ( `PartnerId` ) REFERENCES `partners` ( `PartnerId` );

ALTER TABLE `fashionade_beta`.`outfitupdaters` ADD CONSTRAINT `patterns`
	FOREIGN KEY ( `PatternId` ) REFERENCES `patterns` ( `PatternId` );

ALTER TABLE `fashionade_beta`.`outfitupdaters` ADD CONSTRAINT `silouhettes`
	FOREIGN KEY ( `SilouhetteId` ) REFERENCES `silouhettes` ( `SilouhetteId` );

