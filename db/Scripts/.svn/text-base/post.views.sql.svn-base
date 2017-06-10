DROP VIEW `maxoutfitdetails`;
DROP VIEW `maxoutfitdates`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `maxoutfitdates` AS 
(select `outfitdetails`.`ClosetOutfitId` AS `Id`,max(`outfitdetails`.`WornDate`) AS `MaxDate` from `outfitdetails` group by `outfitdetails`.`ClosetOutfitId`);

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `maxoutfitdetails` AS 
select `d`.`ClosetOutfitId` AS `maxoutfitdetailid`,`d`.`ClosetOutfitId` AS `ClosetOutfitId`,`d`.`WornDate` AS `WornDate`,`d`.`Location` AS `Location` from (`outfitdetails` `d` join `maxoutfitdates` `maximus` on(((`maximus`.`MaxDate` = `d`.`WornDate`) and (`maximus`.`Id` = `d`.`ClosetOutfitId`))));