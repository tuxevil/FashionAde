 ALTER TABLE categories
 DROP FOREIGN KEY categories_ibfk_1,
 ADD `Order` INT AFTER ParentId;
ALTER TABLE categories
 ADD CONSTRAINT categories_ibfk_1 FOREIGN KEY (ParentId) REFERENCES categories (CategoryId) ON UPDATE RESTRICT ON DELETE RESTRICT;

update categories set `order` = categoryid;
update categories set `order` = 10 where CategoryId = 12;
update categories set `order` = 12 where CategoryId = 10;
