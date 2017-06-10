truncate table closetgarments;
truncate table closetoutfits;
truncate table precombinations;
truncate table closets;
truncate table friendratings;
truncate table friends;
truncate table garmentdetails;
truncate table outfitdetails;
truncate table precombinations;
truncate table ratings;
truncate table wishgarments;
truncate table wishlists;

truncate table userbyeventtypes;
truncate table userflavors;
truncate table usergarment;
truncate table useroutfit;
truncate table userratings;

truncate table registereduser;
truncate table inviteduser;
truncate table basicusers;

update _uniquekey set next_hi=1 where table_name = 'basicusers';
update _uniquekey set next_hi=1 where table_name = 'closetgarments';
update _uniquekey set next_hi=1 where table_name = 'closets';
update _uniquekey set next_hi=1 where table_name = 'friendratinginvitations';
update _uniquekey set next_hi=1 where table_name = 'friendratings';
update _uniquekey set next_hi=1 where table_name = 'friends';
update _uniquekey set next_hi=1 where table_name = 'garmentdetails';
update _uniquekey set next_hi=1 where table_name = 'friends';
update _uniquekey set next_hi=1 where table_name = 'oufitdetails';
update _uniquekey set next_hi=1 where table_name = 'userflavors';
update _uniquekey set next_hi=1 where table_name = 'wishgarments';
update _uniquekey set next_hi=1 where table_name = 'wishlists';
update _uniquekey set next_hi=1 where table_name = 'contentsections';
update _uniquekey set next_hi=1 where table_name = 'contentpublishedsections';

delete from my_aspnet_usersinroles where roleId = 1;
delete from my_aspnet_membership where userid not in (select userId from my_aspnet_usersinroles);
delete from my_aspnet_users where id not in (select userId from my_aspnet_usersinroles);

select * from my_aspnet_membership;
select * from my_aspnet_users;
select * from my_aspnet_usersinroles;
