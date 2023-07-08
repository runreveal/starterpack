-- Selects failed AWS login events and access denied events
select COALESCE(NULLIF(userIdentity.userName, ''),
    NULLIF(userIdentity.principalId, ''),
NULLIF(arrayStringConcat(splitByChar('/', COALESCE(userIdentity.arn, ''), 2), '/'), ''),
NULLIF(userIdentity.type, ''), '') identity,
    count(*) failedAttempts,
    arrayCompact(groupArray(sourceIPAddress)) sourceIPAddress,
    arrayCompact(groupArray(srcASOrganization)) srcASOrganization,
    arrayCompact(groupArray(srcASNumber)) srcASNumber,
    arrayCompact(groupArray(srcASCountryCode)) srcASCountryCode
FROM cloudtrail_logs
    where eventType = 'AwsConsoleSignIn' and eventName = 'ConsoleLogin' AND eventTime
between subtractMinutes(now('UTC'), 10) and now('UTC')
AND JSONExtractString(responseElements, 'ConsoleLogin') = 'Failure'
GROUP BY identity HAVING failedAttempts >= 3