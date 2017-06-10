update garments set Type = 2 where garmentid in (select garmentid from usergarment);

update categories set description = 'Tops' where description = 'Shirts';

ALTER TABLE garmentdetails
 CHANGE PurchasedOn PurchasedOn DATE;
 
UPDATE eventtypes SET ShortName = 'Play' WHERE EventTypeId = 1;
UPDATE eventtypes SET ShortName = 'Evening' WHERE EventTypeId = 2;
UPDATE eventtypes SET ShortName = 'Work' WHERE EventTypeId = 3;
UPDATE eventtypes SET ShortName = 'Work' WHERE EventTypeId = 4;
UPDATE eventtypes SET ShortName = 'Play' WHERE EventTypeId = 5;

insert into silouhettesbyflavors
select silouhetteid, 5 from silouhettes where externalcode in ('900122','900123');

insert into silouhettesbyflavors
select silouhetteid, 5 from silouhettes where externalcode in ('777102,777104,777108,777110');