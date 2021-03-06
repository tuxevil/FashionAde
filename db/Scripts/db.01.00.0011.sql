﻿ALTER TABLE outfitupdaters
 DROP FOREIGN KEY silouhettes,
 DROP FOREIGN KEY colorfamily,
 DROP FOREIGN KEY partner,
 DROP FOREIGN KEY patterns,
 CHANGE ExternalId ExternalId VARCHAR(100) NOT NULL;
 
ALTER TABLE outfitupdaters
 ADD CONSTRAINT silouhettes FOREIGN KEY (SilouhetteId) REFERENCES silouhettes (SilouhetteId) ON UPDATE RESTRICT ON DELETE RESTRICT,
 ADD CONSTRAINT colorfamily FOREIGN KEY (ColorFamilyId) REFERENCES colorfamilies (ColorFamilyId) ON UPDATE RESTRICT ON DELETE RESTRICT,
 ADD CONSTRAINT partner FOREIGN KEY (PartnerId) REFERENCES partners (PartnerId) ON UPDATE RESTRICT ON DELETE RESTRICT,
 ADD CONSTRAINT patterns FOREIGN KEY (PatternId) REFERENCES patterns (PatternId) ON UPDATE RESTRICT ON DELETE RESTRICT; 