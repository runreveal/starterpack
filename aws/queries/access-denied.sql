select COALESCE(NULLIF(userIdentity.userName, ''),
    NULLIF(userIdentity.principalId, ''),
NULLIF(userIdentity.arn, ''),
NULLIF(userIdentity.type, ''), '') identity,
count(*) failedAttempts, eventName
from cloudtrail_logs where errorCode = 'AccessDenied'
AND eventTime
between subtractMinutes(now('UTC'), 10) and now('UTC')
GROUP BY identity, eventName HAVING failedAttempts >= 3
ORDER BY failedAttempts desc, eventName