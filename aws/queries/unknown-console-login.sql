-- Checks any console logins in the past 30 minutes to see if that user has
-- 1. Logged in, in the past 30 days
-- 2. Logged in from that Country code in the past 30 days
-- 3. Logged in from that AS Number in the past 30 days
WITH oldAccess as (SELECT DISTINCT COALESCE(NULLIF(userIdentity.userName, ''),
    NULLIF(userIdentity.principalId, ''),
NULLIF(arrayStringConcat(splitByChar('/', COALESCE(userIdentity.arn, ''), 2), '/'), ''),
NULLIF(userIdentity.type, ''), '') identity,
srcASNumber,
srcASOrganization,
srcASCountryCode
FROM cloudtrail_logs
where eventType = 'AwsConsoleSignIn' and eventName = 'ConsoleLogin' AND eventTime
between subtractDays(subtractMinutes(now('UTC'), 30), 30) and subtractMinutes(now('UTC'), 30))

SELECT newAccess.*,
CASE when (identity) NOT IN (SELECT identity from oldAccess) THEN 'New User'
    when (identity, srcASCountryCode) NOT IN (SELECT identity, srcASCountryCode from oldAccess) THEN 'New Country Code'
    when (identity, srcASNumber) NOT IN (SELECT identity, srcASNumber from oldAccess) THEN 'New AS Number'
END reasonType
    FROM
(SELECT eventTime, COALESCE(NULLIF(userIdentity.userName, ''),
    NULLIF(userIdentity.principalId, ''),
NULLIF(arrayStringConcat(splitByChar('/', COALESCE(userIdentity.arn, ''), 2), '/'), ''),
NULLIF(userIdentity.type, ''), '') identity,
JSONExtractString(responseElements, 'ConsoleLogin') as loginStatus,
sourceIPAddress,
srcASNumber,
srcASCountryCode
FROM cloudtrail_logs
where eventType = 'AwsConsoleSignIn' and eventName = 'ConsoleLogin' AND eventTime
between subtractMinutes(now('UTC'), 30) and now('UTC')) newAccess
WHERE (newAccess.identity, newAccess.srcASNumber, newAccess.srcASCountryCode)
          NOT IN (SELECT oldAccess.identity, oldAccess.srcASNumber, oldAccess.srcASCountryCode FROM oldAccess)