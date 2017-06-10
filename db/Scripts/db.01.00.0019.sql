ALTER TABLE trends
 ADD Season INT DEFAULT '2' AFTER name,
 ADD IsEnabled TINYINT DEFAULT '1';

ALTER TABLE outfitupdaters
 ADD Season INT DEFAULT '2';
   
 CREATE TABLE `trendsbyflavors` (
  `TrendId` int(11) NOT NULL DEFAULT '0',
  `FashionFlavorId` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`TrendId`,`FashionFlavorId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- INSERT NEW TREND
INSERT INTO trends
(name, Season, IsEnabled) 
VALUES ('Denim', 4, 1);

INSERT INTO trendsbyflavors
(trendid, fashionflavorid)
VALUES (LAST_INSERT_ID(), 3),
(LAST_INSERT_ID(), 4),
(LAST_INSERT_ID(), 7),
(LAST_INSERT_ID(), 8);

INSERT INTO trendkeywords
(trendid, keyword) 
VALUES (LAST_INSERT_ID(), 'distressed jeans'),
(LAST_INSERT_ID(), 'distressed denim jeans'),
(LAST_INSERT_ID(), 'distressed denim fabric'),
(LAST_INSERT_ID(), 'mens distressed denim'),
(LAST_INSERT_ID(), 'distressed denim jacket'),
(LAST_INSERT_ID(), 'distressed denim'),
(LAST_INSERT_ID(), 'distress denim'),
(LAST_INSERT_ID(), 'distressed denim skirts'),
(LAST_INSERT_ID(), 'distressed demin'),
(LAST_INSERT_ID(), 'distressed blue jeans'),
(LAST_INSERT_ID(), 'distressed jean'),
(LAST_INSERT_ID(), 'distressed skinny jeans'),
(LAST_INSERT_ID(), 'seven jeans distressed'),
(LAST_INSERT_ID(), 'distressed skinny'),
(LAST_INSERT_ID(), 'distressed wash'),
(LAST_INSERT_ID(), 'faded denim'),
(LAST_INSERT_ID(), 'bleached jeans'),
(LAST_INSERT_ID(), 'distressed denim shirt'),
(LAST_INSERT_ID(), 'distress denim jeans'),
(LAST_INSERT_ID(), 'destroyed jeans');

-- INSERT NEW TREND
INSERT INTO trends
(name, Season, IsEnabled) 
VALUES ('Velvet/Velour', 4, 1);

INSERT INTO trendkeywords
(trendid, keyword) 
VALUES (LAST_INSERT_ID(), 'womens pants suit'),
(LAST_INSERT_ID(), 'black velvet jacket'),
(LAST_INSERT_ID(), 'velvet jeans'),
(LAST_INSERT_ID(), 'velvet jacket'),
(LAST_INSERT_ID(), 'velvet coat'),
(LAST_INSERT_ID(), 'velvet jacket women'),
(LAST_INSERT_ID(), 'velvet blazer'),
(LAST_INSERT_ID(), 'velvet top'),
(LAST_INSERT_ID(), 'velvet tank'),
(LAST_INSERT_ID(), 'velvet skirt'),
(LAST_INSERT_ID(), 'velvet jacket ladies'),
(LAST_INSERT_ID(), 'velvet pants'),
(LAST_INSERT_ID(), 'velvet shirt'),
(LAST_INSERT_ID(), 'velvet trousers'),
(LAST_INSERT_ID(), 'velvet t shirts'),
(LAST_INSERT_ID(), 'long velvet coat'),
(LAST_INSERT_ID(), 'velvet pants for women'),
(LAST_INSERT_ID(), 'velvet tee shirts'),
(LAST_INSERT_ID(), 'black velvet coat'),
(LAST_INSERT_ID(), 'velvet tees clothing'),
(LAST_INSERT_ID(), 'velvet evening coat'),
(LAST_INSERT_ID(), 'velvet tunic'),
(LAST_INSERT_ID(), 'velvet jackets'),
(LAST_INSERT_ID(), 'red velvet jacket'),
(LAST_INSERT_ID(), 'black velvet jackets'),
(LAST_INSERT_ID(), 'velvet coats'),
(LAST_INSERT_ID(), 'velvet heart jeans'),
(LAST_INSERT_ID(), 'velvet dinner jacket'),
(LAST_INSERT_ID(), 'blue velvet jacket'),
(LAST_INSERT_ID(), 'black velvet skirt'),
(LAST_INSERT_ID(), 'black velvet coats'),
(LAST_INSERT_ID(), 'velvet shirts'),
(LAST_INSERT_ID(), 'velvet vest'),
(LAST_INSERT_ID(), 'green velvet jacket'),
(LAST_INSERT_ID(), 'velvet blazer women'),
(LAST_INSERT_ID(), 'ladies velvet jacket'),
(LAST_INSERT_ID(), 'velvet skirts'),
(LAST_INSERT_ID(), 'velvet jeans for women'),
(LAST_INSERT_ID(), 'velvet t shirt'),
(LAST_INSERT_ID(), 'velvet shorts'),
(LAST_INSERT_ID(), 'black velvet blazer'),
(LAST_INSERT_ID(), 'black velvet leggings'),
(LAST_INSERT_ID(), 'purple velvet jacket'),
(LAST_INSERT_ID(), 'velvet long coat'),
(LAST_INSERT_ID(), 'black velvet pants'),
(LAST_INSERT_ID(), 'velvet blouses'),
(LAST_INSERT_ID(), 'velvet bolero'),
(LAST_INSERT_ID(), 'womens velvet blazer'),
(LAST_INSERT_ID(), 'long velvet skirt'),
(LAST_INSERT_ID(), 'velvet shirts for women'),
(LAST_INSERT_ID(), 'red velvet coat'),
(LAST_INSERT_ID(), 'velvet blazers'),
(LAST_INSERT_ID(), 'ladies black velvet jacket'),
(LAST_INSERT_ID(), 'velvet coats for women'),
(LAST_INSERT_ID(), 'velvet jumper'),
(LAST_INSERT_ID(), 'black velvet blazer women'),
(LAST_INSERT_ID(), 'velvet tunics'),
(LAST_INSERT_ID(), 'velvet mini skirt'),
(LAST_INSERT_ID(), 'brown velvet jacket'),
(LAST_INSERT_ID(), 'velvet tops for women'),
(LAST_INSERT_ID(), 'velvet sweaters'),
(LAST_INSERT_ID(), 'black velvet jacket ladies'),
(LAST_INSERT_ID(), 'brown velvet blazer'),
(LAST_INSERT_ID(), 'velour tops'),
(LAST_INSERT_ID(), 'velvet jackets for women'),
(LAST_INSERT_ID(), 'long velvet coats'),
(LAST_INSERT_ID(), 'velvet suit jacket'),
(LAST_INSERT_ID(), 'vintage velvet jacket'),
(LAST_INSERT_ID(), 'purple velvet blazer'),
(LAST_INSERT_ID(), 'velvet trousers for women'),
(LAST_INSERT_ID(), 'ladies black velvet trousers'),
(LAST_INSERT_ID(), 'purple velvet coat'),
(LAST_INSERT_ID(), 'velour pants'),
(LAST_INSERT_ID(), 'velour hoodie'),
(LAST_INSERT_ID(), 'mens velour pants'),
(LAST_INSERT_ID(), 'black velour pants'),
(LAST_INSERT_ID(), 'velour pant sets'),
(LAST_INSERT_ID(), 'velour hoodie set'),
(LAST_INSERT_ID(), 'velour hoodie and pants'),
(LAST_INSERT_ID(), 'velour blazer'),
(LAST_INSERT_ID(), 'velour drawstring pants'),
(LAST_INSERT_ID(), 'velour track pants'),
(LAST_INSERT_ID(), 'white velour pants'),
(LAST_INSERT_ID(), 'pink velour pants'),
(LAST_INSERT_ID(), 'velour jacket and pants'),
(LAST_INSERT_ID(), 'velour lounge pants'),
(LAST_INSERT_ID(), 'red velour pants'),
(LAST_INSERT_ID(), 'velour jacket'),
(LAST_INSERT_ID(), 'velour tops'),
(LAST_INSERT_ID(), 'velour shirts'),
(LAST_INSERT_ID(), 'velour pant set'),
(LAST_INSERT_ID(), 'pink velour hoodie'),
(LAST_INSERT_ID(), 'velour jackets'),
(LAST_INSERT_ID(), 'velour trousers'),
(LAST_INSERT_ID(), 'velour pant'),
(LAST_INSERT_ID(), 'custom hoodies'),
(LAST_INSERT_ID(), 'velour shorts'),
(LAST_INSERT_ID(), 'velour top'),
(LAST_INSERT_ID(), 'velour sweatshirt'),
(LAST_INSERT_ID(), 'hooded sweatshirts'),
(LAST_INSERT_ID(), 'velour hoodies'),
(LAST_INSERT_ID(), 'velvet jacket'),
(LAST_INSERT_ID(), 'gaucho pants'),
(LAST_INSERT_ID(), 'petite velour pants'),
(LAST_INSERT_ID(), 'sequin tops'),
(LAST_INSERT_ID(), 'sleeveless hoodie'),
(LAST_INSERT_ID(), 'velour pants suit'),
(LAST_INSERT_ID(), 'velvet blazer'),
(LAST_INSERT_ID(), 'wide leg pants'),
(LAST_INSERT_ID(), 'velour pants set'),
(LAST_INSERT_ID(), 'black velour hoodie'),
(LAST_INSERT_ID(), 'drawstring pants'),
(LAST_INSERT_ID(), 'velour pants sets'),
(LAST_INSERT_ID(), 'velour shirt'),
(LAST_INSERT_ID(), 'velour vest'),
(LAST_INSERT_ID(), 'suit vest'),
(LAST_INSERT_ID(), 'velvet coat'),
(LAST_INSERT_ID(), 'velour lounge'),
(LAST_INSERT_ID(), 'pullover hoodies'),
(LAST_INSERT_ID(), 'white hoodie'),
(LAST_INSERT_ID(), 'velour pullover'),
(LAST_INSERT_ID(), 'velour skirts'),
(LAST_INSERT_ID(), 'velour skirt'),
(LAST_INSERT_ID(), 'velvet shirt'),
(LAST_INSERT_ID(), 'velour track jacket'),
(LAST_INSERT_ID(), 'kimono top'),
(LAST_INSERT_ID(), 'yellow hoodie'),
(LAST_INSERT_ID(), 'buy hoodies'),
(LAST_INSERT_ID(), 'crew neck sweatshirts'),
(LAST_INSERT_ID(), 'velour tunic'),
(LAST_INSERT_ID(), 'hoodie sweater'),
(LAST_INSERT_ID(), 'velvet jeans'),
(LAST_INSERT_ID(), 'velour hooded robe'),
(LAST_INSERT_ID(), 'white sweatpants'),
(LAST_INSERT_ID(), 'velour pants for women'),
(LAST_INSERT_ID(), 'velour drawstring pant'),
(LAST_INSERT_ID(), 'sports hoodies'),
(LAST_INSERT_ID(), 'fashion hoodies'),
(LAST_INSERT_ID(), 'velour sweater'),
(LAST_INSERT_ID(), 'velour jeans'),
(LAST_INSERT_ID(), 'velour hooded jacket'),
(LAST_INSERT_ID(), 'long velvet coat'),
(LAST_INSERT_ID(), 'cropped hoodie'),
(LAST_INSERT_ID(), 'petite velour'),
(LAST_INSERT_ID(), 'velour cardigan'),
(LAST_INSERT_ID(), 'red velour jacket'),
(LAST_INSERT_ID(), 'velour pants and jacket'),
(LAST_INSERT_ID(), 'maternity velour tracksuit'),
(LAST_INSERT_ID(), 'hooded velour'),
(LAST_INSERT_ID(), 'velvet tunic'),
(LAST_INSERT_ID(), 'velour blazers'),
(LAST_INSERT_ID(), 'long velour'),
(LAST_INSERT_ID(), 'velour long skirt'),
(LAST_INSERT_ID(), 'velour pants and hoodie');

INSERT INTO trendsbyflavors
(trendid, fashionflavorid)
VALUES (LAST_INSERT_ID(), 1),
(LAST_INSERT_ID(), 2),
(LAST_INSERT_ID(), 3),
(LAST_INSERT_ID(), 4),
(LAST_INSERT_ID(), 5),
(LAST_INSERT_ID(), 6),
(LAST_INSERT_ID(), 8);

-- INSERT NEW TREND
INSERT INTO trends
(name, Season, IsEnabled) 
VALUES ('Fur', 4, 1);

INSERT INTO trendkeywords
(trendid, keyword) 
VALUES (LAST_INSERT_ID(), 'faux fur coats'),
(LAST_INSERT_ID(), 'fur coats'),
(LAST_INSERT_ID(), 'faux fur coats women'),
(LAST_INSERT_ID(), 'faux fur coats jackets'),
(LAST_INSERT_ID(), 'faux fur fabric'),
(LAST_INSERT_ID(), 'white faux fur coat'),
(LAST_INSERT_ID(), 'faux fur jacket'),
(LAST_INSERT_ID(), 'faux fur vest'),
(LAST_INSERT_ID(), 'black faux fur coat'),
(LAST_INSERT_ID(), 'mink fur coat'),
(LAST_INSERT_ID(), 'leopard faux fur coat'),
(LAST_INSERT_ID(), 'ladies faux fur coats'),
(LAST_INSERT_ID(), 'faux fur coat'),
(LAST_INSERT_ID(), 'fur coats for women'),
(LAST_INSERT_ID(), 'fox fur coat'),
(LAST_INSERT_ID(), 'long faux fur coat'),
(LAST_INSERT_ID(), 'faux fur bolero'),
(LAST_INSERT_ID(), 'rabbit fur coat'),
(LAST_INSERT_ID(), 'fur coats sale'),
(LAST_INSERT_ID(), 'white faux fur jacket'),
(LAST_INSERT_ID(), 'faux fur jackets for women'),
(LAST_INSERT_ID(), 'pink faux fur coat'),
(LAST_INSERT_ID(), 'vintage fur coats'),
(LAST_INSERT_ID(), 'full length faux fur coats'),
(LAST_INSERT_ID(), 'faux fur trim coats'),
(LAST_INSERT_ID(), 'fur trimmed coats'),
(LAST_INSERT_ID(), 'faux fur trim'),
(LAST_INSERT_ID(), 'white faux fur'),
(LAST_INSERT_ID(), 'fur coats jackets'),
(LAST_INSERT_ID(), 'faux fur suede coat'),
(LAST_INSERT_ID(), 'vintage faux fur coat'),
(LAST_INSERT_ID(), 'chinchilla fur coat'),
(LAST_INSERT_ID(), 'white fur coat'),
(LAST_INSERT_ID(), 'real fur coats'),
(LAST_INSERT_ID(), 'faux fur mink coat'),
(LAST_INSERT_ID(), 'ladies fur coats'),
(LAST_INSERT_ID(), 'faux fur hooded jacket'),
(LAST_INSERT_ID(), 'used fur coats'),
(LAST_INSERT_ID(), 'silver fox fur coat'),
(LAST_INSERT_ID(), 'faux fur fashion'),
(LAST_INSERT_ID(), 'black fur coat'),
(LAST_INSERT_ID(), 'fur coat'),
(LAST_INSERT_ID(), 'fur lined coat'),
(LAST_INSERT_ID(), 'faux fox fur'),
(LAST_INSERT_ID(), 'fur collar coat'),
(LAST_INSERT_ID(), 'faux fur jackets'),
(LAST_INSERT_ID(), 'fur coats new york'),
(LAST_INSERT_ID(), 'discount fur coats'),
(LAST_INSERT_ID(), 'lynx fur coat'),
(LAST_INSERT_ID(), 'beaver fur coats'),
(LAST_INSERT_ID(), 'vintage faux fur coats'),
(LAST_INSERT_ID(), 'mink fur coats'),
(LAST_INSERT_ID(), 'leopard fur coat'),
(LAST_INSERT_ID(), 'designer fur coats'),
(LAST_INSERT_ID(), 'blue fox fur coat'),
(LAST_INSERT_ID(), 'faux fur vests'),
(LAST_INSERT_ID(), 'faux fur coats for women'),
(LAST_INSERT_ID(), 'fur jackets'),
(LAST_INSERT_ID(), 'fur vest'),
(LAST_INSERT_ID(), 'womens faux fur coats'),
(LAST_INSERT_ID(), 'fur hooded coats'),
(LAST_INSERT_ID(), 'shearling fur coats'),
(LAST_INSERT_ID(), 'faux fur leopard coat'),
(LAST_INSERT_ID(), 'coyote fur coat'),
(LAST_INSERT_ID(), 'leather fur coat'),
(LAST_INSERT_ID(), 'mink fur'),
(LAST_INSERT_ID(), 'winter fur coats'),
(LAST_INSERT_ID(), 'seal fur coat'),
(LAST_INSERT_ID(), 'faux fur accessories'),
(LAST_INSERT_ID(), 'fur jacket'),
(LAST_INSERT_ID(), 'raccoon fur coat'),
(LAST_INSERT_ID(), 'persian lamb fur coat'),
(LAST_INSERT_ID(), 'red fox fur coat'),
(LAST_INSERT_ID(), 'faux fur clothing'),
(LAST_INSERT_ID(), 'faux mink fur'),
(LAST_INSERT_ID(), 'long faux fur coats'),
(LAST_INSERT_ID(), 'faux fur fabrics'),
(LAST_INSERT_ID(), 'long fur coat'),
(LAST_INSERT_ID(), 'fox fur coats'),
(LAST_INSERT_ID(), 'faux fur lined hoodie'),
(LAST_INSERT_ID(), 'lamb fur coat'),
(LAST_INSERT_ID(), 'leopard print faux fur coat');

INSERT INTO trendsbyflavors
(trendid, fashionflavorid)
VALUES (LAST_INSERT_ID(), 1),
(LAST_INSERT_ID(), 6),
(LAST_INSERT_ID(), 8);

-- INSERT NEW TREND
INSERT INTO trends
(name, Season, IsEnabled) 
VALUES ('Leather', 4, 1);

INSERT INTO trendkeywords
(trendid, keyword) 
VALUES (LAST_INSERT_ID(), 'leather jackets'),
(LAST_INSERT_ID(), 'leather motorcycle jackets'),
(LAST_INSERT_ID(), 'black leather jacket'),
(LAST_INSERT_ID(), 'brown leather jacket'),
(LAST_INSERT_ID(), 'designer leather jackets'),
(LAST_INSERT_ID(), 'leather coats jackets'),
(LAST_INSERT_ID(), 'vintage leather jackets'),
(LAST_INSERT_ID(), 'hooded leather jacket'),
(LAST_INSERT_ID(), 'motorbike leather jackets'),
(LAST_INSERT_ID(), 'italian leather jackets'),
(LAST_INSERT_ID(), 'white leather jacket'),
(LAST_INSERT_ID(), 'leather jackets online'),
(LAST_INSERT_ID(), 'brown leather motorcycle jacket'),
(LAST_INSERT_ID(), 'leather bike jackets'),
(LAST_INSERT_ID(), 'red leather jacket'),
(LAST_INSERT_ID(), 'brown leather bomber jacket'),
(LAST_INSERT_ID(), 'womens leather jackets'),
(LAST_INSERT_ID(), 'ladies leather bomber jacket'),
(LAST_INSERT_ID(), 'vintage leather motorcycle jackets'),
(LAST_INSERT_ID(), 'suede leather jacket'),
(LAST_INSERT_ID(), 'cropped leather jacket'),
(LAST_INSERT_ID(), 'leather dress jackets'),
(LAST_INSERT_ID(), 'ladies leather motorcycle jackets'),
(LAST_INSERT_ID(), 'black leather bomber jacket'),
(LAST_INSERT_ID(), 'fashion leather jackets'),
(LAST_INSERT_ID(), 'lambskin leather jacket'),
(LAST_INSERT_ID(), 'faux leather jacket'),
(LAST_INSERT_ID(), 'tan leather jacket'),
(LAST_INSERT_ID(), 'retro leather jackets'),
(LAST_INSERT_ID(), 'leather flight jackets'),
(LAST_INSERT_ID(), 'punk leather jacket'),
(LAST_INSERT_ID(), 'leather coats'),
(LAST_INSERT_ID(), 'leather blazer jackets'),
(LAST_INSERT_ID(), 'fitted leather jacket'),
(LAST_INSERT_ID(), 'leather flying jackets'),
(LAST_INSERT_ID(), 'studded leather jacket'),
(LAST_INSERT_ID(), 'ladies brown leather jacket'),
(LAST_INSERT_ID(), 'purple leather jacket'),
(LAST_INSERT_ID(), 'short leather jackets'),
(LAST_INSERT_ID(), 'leather riding jackets'),
(LAST_INSERT_ID(), 'leather aviator jacket'),
(LAST_INSERT_ID(), 'leather motorcycle pants'),
(LAST_INSERT_ID(), 'pink leather jacket'),
(LAST_INSERT_ID(), 'yamaha leather jacket'),
(LAST_INSERT_ID(), 'man leather jacket'),
(LAST_INSERT_ID(), 'hooded leather bomber jacket'),
(LAST_INSERT_ID(), 'hip hop leather jackets'),
(LAST_INSERT_ID(), 'leather racing jackets'),
(LAST_INSERT_ID(), 'long leather jacket'),
(LAST_INSERT_ID(), 'leather trench coat'),
(LAST_INSERT_ID(), 'ladies leather coats'),
(LAST_INSERT_ID(), 'suzuki leather jacket'),
(LAST_INSERT_ID(), 'classic leather jacket'),
(LAST_INSERT_ID(), 'petite leather jacket');

INSERT INTO trendsbyflavors
(trendid, fashionflavorid)
VALUES (LAST_INSERT_ID(), 1),
(LAST_INSERT_ID(), 4),
(LAST_INSERT_ID(), 6),
(LAST_INSERT_ID(), 7),
(LAST_INSERT_ID(), 8);

-- INSERT NEW TREND
INSERT INTO trends
(name, Season, IsEnabled) 
VALUES ('Green', 4, 1);

INSERT INTO trendkeywords
(trendid, keyword) 
VALUES (LAST_INSERT_ID(), 'green'),
(LAST_INSERT_ID(), 'lime'),
(LAST_INSERT_ID(), 'olive'),
(LAST_INSERT_ID(), 'chartreuse'),
(LAST_INSERT_ID(), 'yellow green'),
(LAST_INSERT_ID(), 'blue green'),
(LAST_INSERT_ID(), 'light green'),
(LAST_INSERT_ID(), 'dark green'),
(LAST_INSERT_ID(), 'apple '),
(LAST_INSERT_ID(), 'auquamarine'),
(LAST_INSERT_ID(), 'beryl'),
(LAST_INSERT_ID(), 'bice'),
(LAST_INSERT_ID(), 'fir'),
(LAST_INSERT_ID(), 'forest'),
(LAST_INSERT_ID(), 'grass'),
(LAST_INSERT_ID(), 'greenish-blue'),
(LAST_INSERT_ID(), 'jade'),
(LAST_INSERT_ID(), 'kelly'),
(LAST_INSERT_ID(), 'malachite'),
(LAST_INSERT_ID(), 'emerald'),
(LAST_INSERT_ID(), 'moss'),
(LAST_INSERT_ID(), 'pea'),
(LAST_INSERT_ID(), 'peacock'),
(LAST_INSERT_ID(), 'pine'),
(LAST_INSERT_ID(), 'sage'),
(LAST_INSERT_ID(), 'sap'),
(LAST_INSERT_ID(), 'sea'),
(LAST_INSERT_ID(), 'spinach'),
(LAST_INSERT_ID(), 'verdigris'),
(LAST_INSERT_ID(), 'vert'),
(LAST_INSERT_ID(), 'virdian'),
(LAST_INSERT_ID(), 'willow');


INSERT INTO trendsbyflavors
(trendid, fashionflavorid)
VALUES (LAST_INSERT_ID(), 1),
(LAST_INSERT_ID(), 2),
(LAST_INSERT_ID(), 3),
(LAST_INSERT_ID(), 4),
(LAST_INSERT_ID(), 5),
(LAST_INSERT_ID(), 6),
(LAST_INSERT_ID(), 7),
(LAST_INSERT_ID(), 8);

-- INSERT NEW TREND
INSERT INTO trends
(name, Season, IsEnabled) 
VALUES ('Brights', 4, 1); 

INSERT INTO trendkeywords
(trendid, keyword) 
VALUES (LAST_INSERT_ID(), 'bright colors'),
(LAST_INSERT_ID(), 'bright yellow color'),
(LAST_INSERT_ID(), 'bright colour'),
(LAST_INSERT_ID(), 'bright colored'),
(LAST_INSERT_ID(), 'bright orange color'),
(LAST_INSERT_ID(), 'bright white color'),
(LAST_INSERT_ID(), 'bright green color'),
(LAST_INSERT_ID(), 'bright color'),
(LAST_INSERT_ID(), 'bright red color'),
(LAST_INSERT_ID(), 'bright color photos'),
(LAST_INSERT_ID(), 'very bright color'),
(LAST_INSERT_ID(), 'bright gold color'),
(LAST_INSERT_ID(), 'bright pink color'),
(LAST_INSERT_ID(), 'bright purple color'),
(LAST_INSERT_ID(), 'strong color'),
(LAST_INSERT_ID(), 'bright color clothing'),
(LAST_INSERT_ID(), 'bright coral color'),
(LAST_INSERT_ID(), 'bright color pattern'),
(LAST_INSERT_ID(), 'bright color images'),
(LAST_INSERT_ID(), 'bright color t shirts'),
(LAST_INSERT_ID(), 'bright color shirt'),
(LAST_INSERT_ID(), 'bright teal color'),
(LAST_INSERT_ID(), 'bright color patterns'),
(LAST_INSERT_ID(), 'bright turquoise color'),
(LAST_INSERT_ID(), 'bright color combinations'),
(LAST_INSERT_ID(), 'bright yellow'),
(LAST_INSERT_ID(), 'bright color shirts'),
(LAST_INSERT_ID(), 'bright color dress'),
(LAST_INSERT_ID(), 'bright color jeans'),
(LAST_INSERT_ID(), 'bright color flowers'),
(LAST_INSERT_ID(), 'bright colours'),
(LAST_INSERT_ID(), 'bright neon color'),
(LAST_INSERT_ID(), 'with bright colors'),
(LAST_INSERT_ID(), 'really bright colors'),
(LAST_INSERT_ID(), 'other bright colors'),
(LAST_INSERT_ID(), 'pretty bright colors'),
(LAST_INSERT_ID(), 'very bright colors'),
(LAST_INSERT_ID(), 'bright color palettes'),
(LAST_INSERT_ID(), 'plain bright colors'),
(LAST_INSERT_ID(), 'bright orange color code'),
(LAST_INSERT_ID(), 'bright color shoes'),
(LAST_INSERT_ID(), 'bright color prom dresses'),
(LAST_INSERT_ID(), 'bright color purses'),
(LAST_INSERT_ID(), 'bright pink colors'),
(LAST_INSERT_ID(), 'bright color palette'),
(LAST_INSERT_ID(), 'bright color skinny jeans');

INSERT INTO trendsbyflavors
(trendid, fashionflavorid)
VALUES (LAST_INSERT_ID(), 2),
(LAST_INSERT_ID(), 4),
(LAST_INSERT_ID(), 5),
(LAST_INSERT_ID(), 6),
(LAST_INSERT_ID(), 7),
(LAST_INSERT_ID(), 8);

-- INSERT NEW TREND
INSERT INTO trends
(name, Season, IsEnabled) 
VALUES ('Camel', 4, 1);

INSERT INTO trendkeywords
(trendid, keyword) 
VALUES (LAST_INSERT_ID(), 'camel clothing'),
(LAST_INSERT_ID(), 'camel jacket'),
(LAST_INSERT_ID(), 'coat camel'),
(LAST_INSERT_ID(), 'camel shirt'),
(LAST_INSERT_ID(), 'camel t shirt'),
(LAST_INSERT_ID(), 'camel polo'),
(LAST_INSERT_ID(), 'wool coat camel'),
(LAST_INSERT_ID(), 'camel hair blazers'),
(LAST_INSERT_ID(), 'womens camel coat'),
(LAST_INSERT_ID(), 'cashmere camel coat'),
(LAST_INSERT_ID(), 'wool camel coat'),
(LAST_INSERT_ID(), 'camel wrap coat'),
(LAST_INSERT_ID(), 'camel coats for women'),
(LAST_INSERT_ID(), 'camel coat women'),
(LAST_INSERT_ID(), 'camel colored pea coat'),
(LAST_INSERT_ID(), 'camel coat petite'),
(LAST_INSERT_ID(), 'camel colored cardigan'),
(LAST_INSERT_ID(), 'camel colored sweaters'),
(LAST_INSERT_ID(), 'womens camel hair coat'),
(LAST_INSERT_ID(), 'camel colored pants'),
(LAST_INSERT_ID(), 'camel pea coat women'),
(LAST_INSERT_ID(), 'camel wool coats'),
(LAST_INSERT_ID(), 'camel hair pea coat');


INSERT INTO trendsbyflavors
(trendid, fashionflavorid)
VALUES (LAST_INSERT_ID(), 1),
(LAST_INSERT_ID(), 3),
(LAST_INSERT_ID(), 4),
(LAST_INSERT_ID(), 5),
(LAST_INSERT_ID(), 8);

-- INSERT NEW TREND
INSERT INTO trends
(name, Season, IsEnabled) 
VALUES ('Shine/Metallics', 4, 1);

INSERT INTO trendkeywords
(trendid, keyword) 
VALUES (LAST_INSERT_ID(), 'metallic colors'),
(LAST_INSERT_ID(), 'metallic color'),
(LAST_INSERT_ID(), 'metallic colours'),
(LAST_INSERT_ID(), 'metallic blue colors'),
(LAST_INSERT_ID(), 'metallic colour'),
(LAST_INSERT_ID(), 'metallic gray'),
(LAST_INSERT_ID(), 'metalic colors'),
(LAST_INSERT_ID(), 'slate metallic color'),
(LAST_INSERT_ID(), 'blue metallic color'),
(LAST_INSERT_ID(), 'metallic black color'),
(LAST_INSERT_ID(), 'metallic brown color'),
(LAST_INSERT_ID(), 'metallic green color'),
(LAST_INSERT_ID(), 'metallic gray color'),
(LAST_INSERT_ID(), 'black metallic color'),
(LAST_INSERT_ID(), 'gun metal grey color'),
(LAST_INSERT_ID(), 'color gun metal gray'),
(LAST_INSERT_ID(), 'gun metal blue color'),
(LAST_INSERT_ID(), 'metallic red color'),
(LAST_INSERT_ID(), 'metal colors'),
(LAST_INSERT_ID(), 'urban titanium metallic color'),
(LAST_INSERT_ID(), 'metallic pearl'),
(LAST_INSERT_ID(), 'metallic grey color'),
(LAST_INSERT_ID(), 'metallic magenta'),
(LAST_INSERT_ID(), 'pearl colors'),
(LAST_INSERT_ID(), 'metallic violet'),
(LAST_INSERT_ID(), 'orange colors'),
(LAST_INSERT_ID(), 'metallic shade'),
(LAST_INSERT_ID(), 'metallic maroon'),
(LAST_INSERT_ID(), 'metallic orange'),
(LAST_INSERT_ID(), 'metallic green'),
(LAST_INSERT_ID(), 'metallic light'),
(LAST_INSERT_ID(), 'metallic yellow'),
(LAST_INSERT_ID(), 'metallics colors'),
(LAST_INSERT_ID(), 'metallic purple'),
(LAST_INSERT_ID(), 'metallics color');


INSERT INTO trendsbyflavors
(trendid, fashionflavorid)
VALUES (LAST_INSERT_ID(), 2),
(LAST_INSERT_ID(), 6),
(LAST_INSERT_ID(), 7),
(LAST_INSERT_ID(), 8);

-- INSERT NEW TREND
INSERT INTO trends
(name, Season, IsEnabled) 
VALUES ('Boots', 4, 1);

INSERT INTO trendkeywords
(trendid, keyword) 
VALUES (LAST_INSERT_ID(), 'black leather boots'),
(LAST_INSERT_ID(), 'winter boots'),
(LAST_INSERT_ID(), 'ladies leather boots'),
(LAST_INSERT_ID(), 'leather boots on sale'),
(LAST_INSERT_ID(), 'black leather ankle boots'),
(LAST_INSERT_ID(), 'ladies boots'),
(LAST_INSERT_ID(), 'ladies ankle boots'),
(LAST_INSERT_ID(), 'leather boots'),
(LAST_INSERT_ID(), 'boots shoes'),
(LAST_INSERT_ID(), 'brown leather boots'),
(LAST_INSERT_ID(), 'suede knee high boots'),
(LAST_INSERT_ID(), 'black suede boots'),
(LAST_INSERT_ID(), 'ankle boots'),
(LAST_INSERT_ID(), 'sheepskin boots'),
(LAST_INSERT_ID(), 'flat leather boots'),
(LAST_INSERT_ID(), 'emu boots'),
(LAST_INSERT_ID(), 'leather ankle boots'),
(LAST_INSERT_ID(), 'suede boots'),
(LAST_INSERT_ID(), 'black boots'),
(LAST_INSERT_ID(), 'womens leather boots'),
(LAST_INSERT_ID(), 'black ankle boots'),
(LAST_INSERT_ID(), 'white boots'),
(LAST_INSERT_ID(), 'red leather boots'),
(LAST_INSERT_ID(), 'ladies winter boots'),
(LAST_INSERT_ID(), 'cheap emu boots'),
(LAST_INSERT_ID(), 'patent leather boots'),
(LAST_INSERT_ID(), 'brown boots'),
(LAST_INSERT_ID(), 'red boots women'),
(LAST_INSERT_ID(), 'ladies riding boots'),
(LAST_INSERT_ID(), 'ladies motorcycle boots'),
(LAST_INSERT_ID(), 'red boots'),
(LAST_INSERT_ID(), 'tall boots'),
(LAST_INSERT_ID(), 'white ankle boots'),
(LAST_INSERT_ID(), 'fashion winter boots'),
(LAST_INSERT_ID(), 'hiking boots'),
(LAST_INSERT_ID(), 'slipper boots'),
(LAST_INSERT_ID(), 'dress boots'),
(LAST_INSERT_ID(), 'flat boots'),
(LAST_INSERT_ID(), 'pink boots'),
(LAST_INSERT_ID(), 'apres ski boots'),
(LAST_INSERT_ID(), 'rain boots'),
(LAST_INSERT_ID(), 'high heel leather boots');


INSERT INTO trendsbyflavors
(trendid, fashionflavorid)
VALUES (LAST_INSERT_ID(), 1),
(LAST_INSERT_ID(), 2),
(LAST_INSERT_ID(), 3),
(LAST_INSERT_ID(), 4),
(LAST_INSERT_ID(), 5),
(LAST_INSERT_ID(), 6),
(LAST_INSERT_ID(), 7),
(LAST_INSERT_ID(), 8);



-- INSERT NEW TREND
INSERT INTO trends
(name, Season, IsEnabled) 
VALUES ('Skin bags', 4, 1);

INSERT INTO trendkeywords
(trendid, keyword) 
VALUES (LAST_INSERT_ID(), 'zebra print handbags'),
(LAST_INSERT_ID(), 'leopard print bag'),
(LAST_INSERT_ID(), 'zebra print purses'),
(LAST_INSERT_ID(), 'leopard print handbags'),
(LAST_INSERT_ID(), 'giraffe print handbags'),
(LAST_INSERT_ID(), 'giraffe print purses'),
(LAST_INSERT_ID(), 'zebra print bags'),
(LAST_INSERT_ID(), 'printed tote bags'),
(LAST_INSERT_ID(), 'leopard print purse'),
(LAST_INSERT_ID(), 'leopard print tote bag'),
(LAST_INSERT_ID(), 'zebra print tote'),
(LAST_INSERT_ID(), 'leopard print clutch bag'),
(LAST_INSERT_ID(), 'leopard print tote'),
(LAST_INSERT_ID(), 'leopard print clutch'),
(LAST_INSERT_ID(), 'monogrammed tote bags'),
(LAST_INSERT_ID(), 'giraffe print bag'),
(LAST_INSERT_ID(), 'zebra print backpack'),
(LAST_INSERT_ID(), 'cow print purses'),
(LAST_INSERT_ID(), 'zebra handbags'),
(LAST_INSERT_ID(), 'cow print bag'),
(LAST_INSERT_ID(), 'zebra print clutch bag'),
(LAST_INSERT_ID(), 'leopard print scarves'),
(LAST_INSERT_ID(), 'cow print handbags'),
(LAST_INSERT_ID(), 'zebra print tote bag'),
(LAST_INSERT_ID(), 'zebra print duffle bags'),
(LAST_INSERT_ID(), 'leopard print backpack'),
(LAST_INSERT_ID(), 'printed canvas bags'),
(LAST_INSERT_ID(), 'zebra print wallet'),
(LAST_INSERT_ID(), 'zebra bags'),
(LAST_INSERT_ID(), 'zebra purses'),
(LAST_INSERT_ID(), 'zebra print laptop bag'),
(LAST_INSERT_ID(), 'leopard print diaper bag'),
(LAST_INSERT_ID(), 'leopard print handbag'),
(LAST_INSERT_ID(), 'zebra tote bag'),
(LAST_INSERT_ID(), 'leopard handbag'),
(LAST_INSERT_ID(), 'leopard bag'),
(LAST_INSERT_ID(), 'zebra print handbag');


INSERT INTO trendsbyflavors
(trendid, fashionflavorid)
VALUES (LAST_INSERT_ID(), 1),
(LAST_INSERT_ID(), 6),
(LAST_INSERT_ID(), 8);



-- INSERT NEW TREND
INSERT INTO trends
(name, Season, IsEnabled) 
VALUES ('Studded belts', 4, 1);

INSERT INTO trendkeywords
(trendid, keyword) 
VALUES (LAST_INSERT_ID(), 'studded leather belt'),
(LAST_INSERT_ID(), 'black leather studded belt'),
(LAST_INSERT_ID(), 'punk studded belts'),
(LAST_INSERT_ID(), 'crystal studded belts'),
(LAST_INSERT_ID(), '3 row studded belt'),
(LAST_INSERT_ID(), 'vintage studded belt'),
(LAST_INSERT_ID(), 'rhinestone belts'),
(LAST_INSERT_ID(), '4 row studded belt'),
(LAST_INSERT_ID(), 'leather rhinestone belts'),
(LAST_INSERT_ID(), '2 row studded belt');

INSERT INTO trendsbyflavors
(trendid, fashionflavorid)
VALUES (LAST_INSERT_ID(), 3),
(LAST_INSERT_ID(), 4),
(LAST_INSERT_ID(), 6),
(LAST_INSERT_ID(), 7),
(LAST_INSERT_ID(), 8);


-- INSERT NEW TREND
INSERT INTO trends
(name, Season, IsEnabled) 
VALUES ('Head-to-Toe', 4, 1);

INSERT INTO trendkeywords
(trendid, keyword) 
VALUES (LAST_INSERT_ID(), 'monochrome'),
(LAST_INSERT_ID(), 'single color'),
(LAST_INSERT_ID(), 'head to toe'),
(LAST_INSERT_ID(), 'single shade'),
(LAST_INSERT_ID(), 'one shade'),
(LAST_INSERT_ID(), 'one color'),
(LAST_INSERT_ID(), 'monochromatic'),
(LAST_INSERT_ID(), 'all one color'),
(LAST_INSERT_ID(), 'all one shade');

iNSERT INTO trendsbyflavors
(trendid, fashionflavorid)
VALUES (LAST_INSERT_ID(), 1),
(LAST_INSERT_ID(), 6),
(LAST_INSERT_ID(), 8);

-- INSERT NEW TREND
INSERT INTO trends
(name, Season, IsEnabled) 
VALUES ('Military', 4, 1);

INSERT INTO trendkeywords
(trendid, keyword) 
VALUES (LAST_INSERT_ID(), 'military jacket'),
(LAST_INSERT_ID(), 'military style jacket'),
(LAST_INSERT_ID(), 'military shirts'),
(LAST_INSERT_ID(), 'military t shirts'),
(LAST_INSERT_ID(), 'military jackets fashion'),
(LAST_INSERT_ID(), 'military coat'),
(LAST_INSERT_ID(), 'mens military jacket'),
(LAST_INSERT_ID(), 'military apparel'),
(LAST_INSERT_ID(), 'military style shirts'),
(LAST_INSERT_ID(), 'military pants'),
(LAST_INSERT_ID(), 'military jackets'),
(LAST_INSERT_ID(), 'military trench coat'),
(LAST_INSERT_ID(), 'military retirement gifts'),
(LAST_INSERT_ID(), 'military vest'),
(LAST_INSERT_ID(), 'military tactical vest'),
(LAST_INSERT_ID(), 'us military branches'),
(LAST_INSERT_ID(), 'military coats'),
(LAST_INSERT_ID(), 'military jacket women'),
(LAST_INSERT_ID(), 'red military jacket');


INSERT INTO trendsbyflavors
(trendid, fashionflavorid)
VALUES (LAST_INSERT_ID(), 4),
(LAST_INSERT_ID(), 6),
(LAST_INSERT_ID(), 8);



-- INSERT NEW TREND
INSERT INTO trends
(name, Season, IsEnabled) 
VALUES ('50s/60s (twinset, pearls)', 4, 1);

INSERT INTO trendkeywords
(trendid, keyword) 
VALUES (LAST_INSERT_ID(), '60s fashion clothes'),
(LAST_INSERT_ID(), 'sixties inspired dresses'),
(LAST_INSERT_ID(), '1960 clothes fashion'),
(LAST_INSERT_ID(), '60s inspired dresses'),
(LAST_INSERT_ID(), 'clothes from the 1960s'),
(LAST_INSERT_ID(), '1960s prom'),
(LAST_INSERT_ID(), '60s prom'),
(LAST_INSERT_ID(), '50s 60s fancy dress'),
(LAST_INSERT_ID(), '50s fashion pictures'),
(LAST_INSERT_ID(), '60s style shoes'),
(LAST_INSERT_ID(), 'dresses in the 60s'),
(LAST_INSERT_ID(), 'twinsets'),
(LAST_INSERT_ID(), 'sheath'),
(LAST_INSERT_ID(), 'sheath dress'),
(LAST_INSERT_ID(), 'shift'),
(LAST_INSERT_ID(), 'shift dress'),
(LAST_INSERT_ID(), 'stilletto heels'),
(LAST_INSERT_ID(), 'circle skirt'),
(LAST_INSERT_ID(), 'gloves'),
(LAST_INSERT_ID(), 'frame bag'),
(LAST_INSERT_ID(), 'pencil skirt');

INSERT INTO trendsbyflavors
(trendid, fashionflavorid)
VALUES (LAST_INSERT_ID(), 1),
(LAST_INSERT_ID(), 2),
(LAST_INSERT_ID(), 5),
(LAST_INSERT_ID(), 6),
(LAST_INSERT_ID(), 8);



-- INSERT NEW TREND
INSERT INTO trends
(name, Season, IsEnabled) 
VALUES ('Graffiti', 4, 1);

INSERT INTO trendkeywords
(trendid, keyword) 
VALUES (LAST_INSERT_ID(), 'graffiti t shirts'),
(LAST_INSERT_ID(), 'graffiti shirts'),
(LAST_INSERT_ID(), 'graffiti hoodies'),
(LAST_INSERT_ID(), 'graffiti t shirt'),
(LAST_INSERT_ID(), 'graffiti tee shirts'),
(LAST_INSERT_ID(), 'graffiti shirt'),
(LAST_INSERT_ID(), 'graffiti clothes'),
(LAST_INSERT_ID(), 't shirt graffiti'),
(LAST_INSERT_ID(), 'graffiti apparel'),
(LAST_INSERT_ID(), 'graffiti jeans'),
(LAST_INSERT_ID(), 'graffiti tees');

INSERT INTO trendsbyflavors
(trendid, fashionflavorid)
VALUES (LAST_INSERT_ID(), 3),
(LAST_INSERT_ID(), 4),
(LAST_INSERT_ID(), 8);

-- INSERT NEW TREND
INSERT INTO trends
(name, Season, IsEnabled) 
VALUES ('Animal Prints', 4, 1);

INSERT INTO trendkeywords
(trendid, keyword) 
VALUES (LAST_INSERT_ID(), 'leopard print top'),
(LAST_INSERT_ID(), 'leopard print coat'),
(LAST_INSERT_ID(), 'leopard print jacket'),
(LAST_INSERT_ID(), 'leopard print cardigan'),
(LAST_INSERT_ID(), 'leopard print hoodie'),
(LAST_INSERT_ID(), 'leopard print shirt'),
(LAST_INSERT_ID(), 'leopard print vest'),
(LAST_INSERT_ID(), 'leopard print blouse'),
(LAST_INSERT_ID(), 'leopard print pant '),
(LAST_INSERT_ID(), 'leopard print dress '),
(LAST_INSERT_ID(), 'leopard print shoe '),
(LAST_INSERT_ID(), 'leopard print boot '),
(LAST_INSERT_ID(), 'leopard print bag '),
(LAST_INSERT_ID(), 'leopard print purse '),
(LAST_INSERT_ID(), 'leopard print t shirt'),
(LAST_INSERT_ID(), 'leopard print pants'),
(LAST_INSERT_ID(), 'leopard print sweater'),
(LAST_INSERT_ID(), 'leopard print jeans'),
(LAST_INSERT_ID(), 'leopard print tank top'),
(LAST_INSERT_ID(), 'leopard shirt'),
(LAST_INSERT_ID(), 'leopard t shirt'),
(LAST_INSERT_ID(), 'leopard tank top'),
(LAST_INSERT_ID(), 'leopard print tutu'),
(LAST_INSERT_ID(), 'leopard print raincoat'),
(LAST_INSERT_ID(), 'cheetah print top'),
(LAST_INSERT_ID(), 'cheetah print coat'),
(LAST_INSERT_ID(), 'cheetah print jacket'),
(LAST_INSERT_ID(), 'cheetah print cardigan'),
(LAST_INSERT_ID(), 'cheetah print hoodie'),
(LAST_INSERT_ID(), 'cheetah print shirt'),
(LAST_INSERT_ID(), 'cheetah print vest'),
(LAST_INSERT_ID(), 'cheetah print blouse'),
(LAST_INSERT_ID(), 'cheetah print pant '),
(LAST_INSERT_ID(), 'cheetah print dress '),
(LAST_INSERT_ID(), 'cheetah print shoe '),
(LAST_INSERT_ID(), 'cheetah print boot '),
(LAST_INSERT_ID(), 'cheetah print bag '),
(LAST_INSERT_ID(), 'cheetah print purse '),
(LAST_INSERT_ID(), 'cheetah print t shirt'),
(LAST_INSERT_ID(), 'cheetah print pants'),
(LAST_INSERT_ID(), 'cheetah print sweater'),
(LAST_INSERT_ID(), 'cheetah print jeans'),
(LAST_INSERT_ID(), 'cheetah print tank top'),
(LAST_INSERT_ID(), 'cheetah shirt'),
(LAST_INSERT_ID(), 'cheetah t shirt'),
(LAST_INSERT_ID(), 'cheetah tank top'),
(LAST_INSERT_ID(), 'cheetah print tutu'),
(LAST_INSERT_ID(), 'cheetah print raincoat'),
(LAST_INSERT_ID(), 'zebra print top'),
(LAST_INSERT_ID(), 'zebra print coat'),
(LAST_INSERT_ID(), 'zebra print jacket'),
(LAST_INSERT_ID(), 'zebra print cardigan'),
(LAST_INSERT_ID(), 'zebra print hoodie'),
(LAST_INSERT_ID(), 'zebra print shirt'),
(LAST_INSERT_ID(), 'zebra print vest'),
(LAST_INSERT_ID(), 'zebra print blouse'),
(LAST_INSERT_ID(), 'zebra print pant '),
(LAST_INSERT_ID(), 'zebra print dress '),
(LAST_INSERT_ID(), 'zebra print shoe '),
(LAST_INSERT_ID(), 'zebra print boot '),
(LAST_INSERT_ID(), 'zebra print bag '),
(LAST_INSERT_ID(), 'zebra print purse '),
(LAST_INSERT_ID(), 'zebra print t shirt'),
(LAST_INSERT_ID(), 'zebra print pants'),
(LAST_INSERT_ID(), 'zebra print sweater'),
(LAST_INSERT_ID(), 'zebra print jeans'),
(LAST_INSERT_ID(), 'zebra print tank top'),
(LAST_INSERT_ID(), 'zebra shirt'),
(LAST_INSERT_ID(), 'zebra t shirt'),
(LAST_INSERT_ID(), 'zebra tank top'),
(LAST_INSERT_ID(), 'zebra print tutu'),
(LAST_INSERT_ID(), 'zebra print raincoat'),
(LAST_INSERT_ID(), 'animal print print top'),
(LAST_INSERT_ID(), 'animal print print coat'),
(LAST_INSERT_ID(), 'animal print print jacket'),
(LAST_INSERT_ID(), 'animal print print cardigan'),
(LAST_INSERT_ID(), 'animal print print hoodie'),
(LAST_INSERT_ID(), 'animal print print shirt'),
(LAST_INSERT_ID(), 'animal print print vest'),
(LAST_INSERT_ID(), 'animal print print blouse'),
(LAST_INSERT_ID(), 'animal print print pant '),
(LAST_INSERT_ID(), 'animal print print dress '),
(LAST_INSERT_ID(), 'animal print print shoe '),
(LAST_INSERT_ID(), 'animal print print boot '),
(LAST_INSERT_ID(), 'animal print print bag '),
(LAST_INSERT_ID(), 'animal print print purse '),
(LAST_INSERT_ID(), 'animal print print t shirt'),
(LAST_INSERT_ID(), 'animal print print pants'),
(LAST_INSERT_ID(), 'animal print print sweater'),
(LAST_INSERT_ID(), 'animal print print jeans'),
(LAST_INSERT_ID(), 'animal print print tank top'),
(LAST_INSERT_ID(), 'animal print shirt'),
(LAST_INSERT_ID(), 'animal print t shirt'),
(LAST_INSERT_ID(), 'animal print tank top'),
(LAST_INSERT_ID(), 'animal print print tutu'),
(LAST_INSERT_ID(), 'animal print print raincoat');

INSERT INTO trendsbyflavors
(trendid, fashionflavorid)
VALUES (LAST_INSERT_ID(), 1),
(LAST_INSERT_ID(), 4),
(LAST_INSERT_ID(), 6),
(LAST_INSERT_ID(), 8);

-- INSERT NEW TREND
INSERT INTO trends
(name, Season, IsEnabled) 
VALUES ('Abstract - Scribble/paint/newspaper', 4, 1);

INSERT INTO trendkeywords
(trendid, keyword) 
VALUES (LAST_INSERT_ID(), 'abstract print'),
(LAST_INSERT_ID(), 'geometric print');

INSERT INTO trendsbyflavors
(trendid, fashionflavorid)
VALUES (LAST_INSERT_ID(), 3),
(LAST_INSERT_ID(), 4),
(LAST_INSERT_ID(), 6),
(LAST_INSERT_ID(), 8);


-- INSERT NEW TREND
INSERT INTO trends
(name, Season, IsEnabled) 
VALUES ('Long Coat', 4, 1);

INSERT INTO trendkeywords
(trendid, keyword) 
VALUES (LAST_INSERT_ID(), 'long coat'),
(LAST_INSERT_ID(), 'long wool coat'),
(LAST_INSERT_ID(), 'long winter coats'),
(LAST_INSERT_ID(), 'trench coat'),
(LAST_INSERT_ID(), 'long down coat'),
(LAST_INSERT_ID(), 'long black coat'),
(LAST_INSERT_ID(), 'long trench coat'),
(LAST_INSERT_ID(), 'long leather coats'),
(LAST_INSERT_ID(), 'long pea coat'),
(LAST_INSERT_ID(), 'leather trench coat'),
(LAST_INSERT_ID(), 'wool trench coat'),
(LAST_INSERT_ID(), 'ladies long coats'),
(LAST_INSERT_ID(), 'long brown coat'),
(LAST_INSERT_ID(), 'plus size long coat'),
(LAST_INSERT_ID(), 'black trench coat'),
(LAST_INSERT_ID(), 'long sweater coats'),
(LAST_INSERT_ID(), 'long white coat'),
(LAST_INSERT_ID(), 'long coats'),
(LAST_INSERT_ID(), 'long velvet coat'),
(LAST_INSERT_ID(), 'long hooded coat'),
(LAST_INSERT_ID(), 'long quilted coat'),
(LAST_INSERT_ID(), 'ladies trench coat'),
(LAST_INSERT_ID(), 'long suede coat'),
(LAST_INSERT_ID(), 'long puffer coat'),
(LAST_INSERT_ID(), 'double breasted trench coat'),
(LAST_INSERT_ID(), 'long black trench coat'),
(LAST_INSERT_ID(), 'long waterproof coat'),
(LAST_INSERT_ID(), 'ladies coats'),
(LAST_INSERT_ID(), 'wool cashmere coat'),
(LAST_INSERT_ID(), 'fur coats'),
(LAST_INSERT_ID(), 'shearling coats for women'),
(LAST_INSERT_ID(), 'faux fur coats'),
(LAST_INSERT_ID(), 'long red coat'),
(LAST_INSERT_ID(), 'long denim coat'),
(LAST_INSERT_ID(), 'shearling coats'),
(LAST_INSERT_ID(), 'red trench coat'),
(LAST_INSERT_ID(), 'long sweater coat'),
(LAST_INSERT_ID(), 'plus size leather coats'),
(LAST_INSERT_ID(), 'long dress coats'),
(LAST_INSERT_ID(), 'long fur coat'),
(LAST_INSERT_ID(), 'red wool coat'),
(LAST_INSERT_ID(), 'white trench coat'),
(LAST_INSERT_ID(), 'sweater coat'),
(LAST_INSERT_ID(), 'frock coat'),
(LAST_INSERT_ID(), 'long wool coats'),
(LAST_INSERT_ID(), 'long coats for women'),
(LAST_INSERT_ID(), 'hooded wool coat'),
(LAST_INSERT_ID(), 'suede trench coat'),
(LAST_INSERT_ID(), 'cashmere long coat'),
(LAST_INSERT_ID(), 'toggle coat'),
(LAST_INSERT_ID(), 'long winter coat'),
(LAST_INSERT_ID(), 'hooded trench coat'),
(LAST_INSERT_ID(), 'down winter coats');

INSERT INTO trendsbyflavors
(trendid, fashionflavorid)
VALUES (LAST_INSERT_ID(), 1),
(LAST_INSERT_ID(), 4),
(LAST_INSERT_ID(), 5),
(LAST_INSERT_ID(), 6),
(LAST_INSERT_ID(), 8);

-- INSERT NEW TREND
INSERT INTO trends
(name, Season, IsEnabled) 
VALUES ('Pants Suits', 4, 1);

INSERT INTO trendsbyflavors
(trendid, fashionflavorid)
VALUES (LAST_INSERT_ID(), 1),
(LAST_INSERT_ID(), 5),
(LAST_INSERT_ID(), 6),
(LAST_INSERT_ID(), 8);

INSERT INTO trendkeywords
(trendid, keyword) 
VALUES (LAST_INSERT_ID(), 'womens pants suit'),
(LAST_INSERT_ID(), 'womens pants suits'),
(LAST_INSERT_ID(), 'womens white pants suit'),
(LAST_INSERT_ID(), 'women''s pants suit'),
(LAST_INSERT_ID(), 'black pants suit'),
(LAST_INSERT_ID(), 'womens white suit'),
(LAST_INSERT_ID(), 'womens black suit'),
(LAST_INSERT_ID(), 'white linen suit'),
(LAST_INSERT_ID(), 'women''s pants suits'),
(LAST_INSERT_ID(), 'womens dress suit'),
(LAST_INSERT_ID(), 'women pants suit'),
(LAST_INSERT_ID(), 'designer pants suit'),
(LAST_INSERT_ID(), 'velvet pants suit'),
(LAST_INSERT_ID(), 'white pants suit'),
(LAST_INSERT_ID(), 'dress pants suit'),
(LAST_INSERT_ID(), 'ladies pants suit'),
(LAST_INSERT_ID(), 'brown pants suit'),
(LAST_INSERT_ID(), 'women pants suits'),
(LAST_INSERT_ID(), 'womens wool suit'),
(LAST_INSERT_ID(), 'womens linen suit'),
(LAST_INSERT_ID(), 'tailored suits women'),
(LAST_INSERT_ID(), 'womens blue suit'),
(LAST_INSERT_ID(), 'womens shorts suit'),
(LAST_INSERT_ID(), 'suit double breasted'),
(LAST_INSERT_ID(), 'fashion suit'),
(LAST_INSERT_ID(), 'women''s business suits'),
(LAST_INSERT_ID(), 'business suits for women'),
(LAST_INSERT_ID(), 'coat suit'),
(LAST_INSERT_ID(), 'casual suit'),
(LAST_INSERT_ID(), 'womens designer suit'),
(LAST_INSERT_ID(), 'women career suits'),
(LAST_INSERT_ID(), 'women work suits'),
(LAST_INSERT_ID(), 'women dress suits'),
(LAST_INSERT_ID(), 'suits ladies'),
(LAST_INSERT_ID(), 'designer suits for women'),
(LAST_INSERT_ID(), 'women''s pant suits'),
(LAST_INSERT_ID(), 'womens business suits'),
(LAST_INSERT_ID(), 'woman pants suit'),
(LAST_INSERT_ID(), 'designer womens suits'),
(LAST_INSERT_ID(), 'pants shirt'),
(LAST_INSERT_ID(), 'women''s pant suit'),
(LAST_INSERT_ID(), 'womens pant suit'),
(LAST_INSERT_ID(), 'woman''s pant suits'),
(LAST_INSERT_ID(), 'womens petite suit');

-- INSERT NEW TREND
INSERT INTO trends
(name, Season, IsEnabled) 
VALUES ('Long Skirts', 4, 1);

INSERT INTO trendkeywords
(trendid, keyword) 
VALUES (LAST_INSERT_ID(), 'long skirt'),
(LAST_INSERT_ID(), 'long skirts'),
(LAST_INSERT_ID(), 'long skirts for women'),
(LAST_INSERT_ID(), 'long denim skirts'),
(LAST_INSERT_ID(), 'long black skirt'),
(LAST_INSERT_ID(), 'long white skirt'),
(LAST_INSERT_ID(), 'long khaki skirt'),
(LAST_INSERT_ID(), 'long pencil skirt'),
(LAST_INSERT_ID(), 'modest long skirts'),
(LAST_INSERT_ID(), 'petite long skirt'),
(LAST_INSERT_ID(), 'long red skirt'),
(LAST_INSERT_ID(), 'long skirts for tall women'),
(LAST_INSERT_ID(), 'ladies long skirts'),
(LAST_INSERT_ID(), 'pencil skirt'),
(LAST_INSERT_ID(), 'long skirts for juniors'),
(LAST_INSERT_ID(), 'long skirt suits'),
(LAST_INSERT_ID(), 'plus size long skirts'),
(LAST_INSERT_ID(), 'long tiered skirt'),
(LAST_INSERT_ID(), 'long leather skirt'),
(LAST_INSERT_ID(), 'high waisted skirts'),
(LAST_INSERT_ID(), 'fashion long skirts'),
(LAST_INSERT_ID(), 'long flowing skirts'),
(LAST_INSERT_ID(), 'long gypsy skirts'),
(LAST_INSERT_ID(), 'black pencil skirt'),
(LAST_INSERT_ID(), 'long formal skirts'),
(LAST_INSERT_ID(), 'long knit skirt'),
(LAST_INSERT_ID(), 'long denim skirts for women'),
(LAST_INSERT_ID(), 'long brown skirt'),
(LAST_INSERT_ID(), 'long wool skirt'),
(LAST_INSERT_ID(), 'long satin skirt'),
(LAST_INSERT_ID(), 'gypsy skirts'),
(LAST_INSERT_ID(), 'designer long skirts'),
(LAST_INSERT_ID(), 'extra long skirts'),
(LAST_INSERT_ID(), 'a line skirt'),
(LAST_INSERT_ID(), 'knee length skirts'),
(LAST_INSERT_ID(), 'white pencil skirt'),
(LAST_INSERT_ID(), 'high waisted pencil skirt'),
(LAST_INSERT_ID(), 'denim pencil skirt'),
(LAST_INSERT_ID(), 'tiered skirt'),
(LAST_INSERT_ID(), 'long crinkle skirt'),
(LAST_INSERT_ID(), 'long pleated skirt'),
(LAST_INSERT_ID(), 'long wrap skirt'),
(LAST_INSERT_ID(), 'long corduroy skirt'),
(LAST_INSERT_ID(), 'long chiffon skirt'),
(LAST_INSERT_ID(), 'maxi skirt'),
(LAST_INSERT_ID(), 'long silk skirt'),
(LAST_INSERT_ID(), 'long casual skirts'),
(LAST_INSERT_ID(), 'broomstick skirt'),
(LAST_INSERT_ID(), 'long full skirts'),
(LAST_INSERT_ID(), 'long blue skirt'),
(LAST_INSERT_ID(), 'long peasant skirts'),
(LAST_INSERT_ID(), 'peasant skirt'),
(LAST_INSERT_ID(), 'tulip skirt'),
(LAST_INSERT_ID(), 'long cargo skirt'),
(LAST_INSERT_ID(), 'modest skirts'),
(LAST_INSERT_ID(), 'ankle length skirts'),
(LAST_INSERT_ID(), 'long plaid skirt'),
(LAST_INSERT_ID(), 'designer skirts'),
(LAST_INSERT_ID(), 'long green skirt'),
(LAST_INSERT_ID(), 'red pencil skirt'),
(LAST_INSERT_ID(), 'long velvet skirt'),
(LAST_INSERT_ID(), 'long navy skirt');

INSERT INTO trendsbyflavors
(trendid, fashionflavorid)
VALUES (LAST_INSERT_ID(), 1),
(LAST_INSERT_ID(), 2),
(LAST_INSERT_ID(), 3),
(LAST_INSERT_ID(), 6),
(LAST_INSERT_ID(), 7),
(LAST_INSERT_ID(), 8);

-- INSERT NEW TREND
INSERT INTO trends
(name, Season, IsEnabled) 
VALUES ('Cape/Poncho', 4, 1);

INSERT INTO trendkeywords
(trendid, keyword) 
VALUES (LAST_INSERT_ID(), 'black cape'),
(LAST_INSERT_ID(), 'hooded cape'),
(LAST_INSERT_ID(), 'poncho'),
(LAST_INSERT_ID(), 'cape coat'),
(LAST_INSERT_ID(), 'red hooded cape'),
(LAST_INSERT_ID(), 'cape poncho'),
(LAST_INSERT_ID(), 'black hooded cape'),
(LAST_INSERT_ID(), 'hooded capes'),
(LAST_INSERT_ID(), 'black velvet cape'),
(LAST_INSERT_ID(), 'black capes'),
(LAST_INSERT_ID(), 'red velvet cape'),
(LAST_INSERT_ID(), 'cape coats'),
(LAST_INSERT_ID(), 'cape jacket'),
(LAST_INSERT_ID(), 'velvet hooded cape'),
(LAST_INSERT_ID(), 'cape clothing'),
(LAST_INSERT_ID(), 'faux fur capes'),
(LAST_INSERT_ID(), 'poncho clothing'),
(LAST_INSERT_ID(), 'sweater cape'),
(LAST_INSERT_ID(), 'wool capes for women'),
(LAST_INSERT_ID(), 'short cape'),
(LAST_INSERT_ID(), 'cape coats for women'),
(LAST_INSERT_ID(), 'cape cod jewelry bracelet'),
(LAST_INSERT_ID(), 'white faux fur cape'),
(LAST_INSERT_ID(), 'plus size poncho'),
(LAST_INSERT_ID(), 'wool cape coat');

INSERT INTO trendsbyflavors
(trendid, fashionflavorid)
VALUES (LAST_INSERT_ID(), 1),
(LAST_INSERT_ID(), 2),
(LAST_INSERT_ID(), 3),
(LAST_INSERT_ID(), 4),
(LAST_INSERT_ID(), 5),
(LAST_INSERT_ID(), 6),
(LAST_INSERT_ID(), 7),
(LAST_INSERT_ID(), 8);