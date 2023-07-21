-- Shows user, and AS number/country_code combination that has not been seen in the past 30 days.
SELECT coalesce(nullIf(CASE WHEN userIdentity.type = 'Root' THEN `userIdentity.arn`
        WHEN userIdentity.type = 'IAMUser' THEN userIdentity.userName
        WHEN userIdentity.type = 'AssumedRole' AND
             startsWith(userIdentity.sessionContext.sessionIssuer.userName, 'AWSReservedSSO_') THEN `userIdentity.principalId`
        WHEN userIdentity.type = 'AssumedRole' THEN `userIdentity.sessionContext.sessionIssuer.userName`END, ''), `userIdentity.arn`) identity,
srcASNumber,
srcASCountryCode,
max(eventTime) lastAccessTime
FROM cloudtrail_logs
where identity <> '' AND
    eventTime between subtractDays(now('UTC'), 30) and now('UTC')
  AND srcASCountryCode IS NOT NULL AND srcASNumber IS NOT NULL
GROUP BY identity, srcASNumber, srcASCountryCode HAVING lastAccessTime >= subtractMinutes(now('UTC'), 15) AND COUNT(*) = 1
