-- 100115 goes to Slim 100 (10).
-- 900101 goes to Fitted 900 (9).
update silouhettes set shapeid = 10 where externalcode = '100115';
update silouhettes set shapeid = 9 where externalcode = '900101';

-- Add Loose 100 (19) and Fitted 900 (9) for Trendy on the rules.
INSERT INTO fashionade_qa.stylerulesshapes
(FromItem, ToItem, StyleRuleId) 
VALUES (19, 9, 8);

-- Add all pattern rules to romantic
DELETE FROM stylerulespatterns where StyleRuleId = 2;
INSERT INTO stylerulespatterns
(FromItem, ToItem, StyleRuleId) 
VALUES 
(1, 1, 2),
(1, 2, 2),
(1, 3, 2),
(1, 4, 2),
(2, 2, 2),
(2, 3, 2),
(2, 4, 2),
(3, 3, 2),
(3, 4, 2),
(4, 4, 2);
 