/* UPDATE RULES */
insert into stylerulesstructures
(FromItem, ToItem, StyleRuleId)
VALUES
(1,3,2),
(3,3,2),
(3,4,2);

insert into stylerulesstructures
(FromItem, ToItem, StyleRuleId)
VALUES
(1,3,7),
(3,3,7),
(3,4,7);

update stylerules
set
	ColorBlending_NeutralPrimaryColor = 1
where
	 styleruleid=2;
	 
update colorfamilies
set
	IsNeutral = 1,
	IsPrimary = 0
where
	colorfamilyid = 1;