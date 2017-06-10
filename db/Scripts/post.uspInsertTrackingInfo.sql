DROP PROCEDURE IF EXISTS uspInsertTrackingInfo;

DELIMITER |
CREATE PROCEDURE `uspInsertTrackingInfo`(IN Controller VARCHAR(100), IN Action VARCHAR(100), IN TrackingIdentifier CHAR(36), IN IP VARCHAr(15), IN UserId INT, IN Channel VARCHAR(50), IN AdditionalDataId INT, IN AdditionalData VARCHAR(100))
BEGIN
INSERT DELAYED INTO tracking (
     Controller
    ,Action 
    ,TrackingIdentifier
    ,IP
    ,UserId
    ,Channel
    ,AdditionalDataId
    ,AdditionalData
  ) VALUES (     
      Controller 
    , Action   
    , TrackingIdentifier
    , INET_ATON(IP)
    , UserId
    , Channel
    , AdditionalDataId
    , AdditionalData
  );

END|
